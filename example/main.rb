#
# (c) Copyright Ascensio System SIA 2025
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# typed: strict
# frozen_string_literal: true

require "onlyoffice/docs_integration_sdk"
require "open-uri"
require "sorbet-runtime"
require "webrick"

extend T::Sig

DOCUMENT_SERVER_BASE_URL = T.let(T.must(ENV["DOCUMENT_SERVER_BASE_URL"]), String)
DOCUMENT_SERVER_JWT_SECRET = T.let(T.must(ENV["DOCUMENT_SERVER_JWT_SECRET"]), String)

EXAMPLE_HOST = T.let(T.must(ENV["EXAMPLE_HOST"]), String)
EXAMPLE_PORT = T.let(T.must(ENV["EXAMPLE_PORT"]), String)
EXAMPLE_INTERNAL_HOST = T.let(T.must(ENV["EXAMPLE_INTERNAL_HOST"]), String)
EXAMPLE_INTERNAL_PORT = T.let(T.must(ENV["EXAMPLE_INTERNAL_PORT"]), String)
EXAMPLE_INTERNAL_URL = T.let("http://#{EXAMPLE_INTERNAL_HOST}:#{EXAMPLE_INTERNAL_PORT}/", String)

SAMPLE_URL = "https://raw.githubusercontent.com/ONLYOFFICE/document-templates/refs/tags/v8.2.2.26/sample/sample.docx"

sig {void}
def main
  base_uri = URI.parse(DOCUMENT_SERVER_BASE_URL)
  if !base_uri.is_a?(URI::HTTP)
    raise ArgumentError, "The Document Server base URL must be an URI::HTTP, but got #{base_uri.class}"
  end

  client = Onlyoffice::DocsIntegrationSdk::DocumentServer::Client.new(
    base_uri: base_uri,
  )

  jwt = Onlyoffice::DocsIntegrationSdk::Jwt.new(
    secret: DOCUMENT_SERVER_JWT_SECRET,
  )

  client_jwt = Onlyoffice::DocsIntegrationSdk::DocumentServer::Client::Jwt.new(
    jwt: jwt,
  )

  client = client.with_jwt(client_jwt)

  server = WEBrick::HTTPServer.new(
    BindAddress: EXAMPLE_HOST,
    Port: EXAMPLE_PORT,
  )

  server.mount_proc("/download", ->(_, res) do
    dir = "tmp"
    if !Dir.exist?(dir)
      Dir.mkdir(dir)
    end

    file = File.join(dir, "sample.docx")
    if File.exist?(file)
      File.delete(file)
    end

    URI.open(SAMPLE_URL) do |res|
      File.open(file, "wb") do |content|
        content.write(res.read)
      end
    end

    res.body = "The sample file has been downloaded"
  end)

  server.mount_proc("/healthcheck", ->(_, res) do
    healthcheck_res = client.healthcheck.do
    if healthcheck_res.error
      res.status = 500
      res.body = "Document Server is not available"
    else
      res.body = "Document Server is available"
    end
  end)

  server.mount_proc("/convert", ->(_, res) do
    conversion_req = Onlyoffice::DocsIntegrationSdk::DocumentServer::Client::ConversionService::Request.new(
      filetype: "docx",
      key: "sample-docx",
      outputtype: "pdf",
      title: "result.pdf",
      url: URI.join(EXAMPLE_INTERNAL_URL, "sample.docx").to_s,
    )

    result, conversion_res = client.conversion.do(conversion_req)
    if conversion_res.error
      error = conversion_res.error

      body = ""
      if error.is_a?(Onlyoffice::DocsIntegrationSdk::DocumentServer::Client::ConversionService::Error)
        body = "Conversion failed with error: #{error.description}"
      else
        body = "Conversion failed with error: #{error}"
      end

      res.status = 500
      res.body = body

      return
    end

    url = result.file_url
    if !url
      res.status = 500
      res.body = "The conversion result does not contain a file URL"
      return
    end

    dir = "tmp"

    file = File.join(dir, "result.pdf")
    if File.exist?(file)
      File.delete(file)
    end

    URI.open(url) do |res|
      File.open(file, "wb") do |content|
        content.write(res.read)
      end
    end

    res.body = "The conversion result has been downloaded"
  end)

  server.mount_proc("/sample.docx", ->(_, res) do
    dir = "tmp"

    file = File.join(dir, "sample.docx")
    if !File.exist?(file)
      res.status = 404
      res.body = "The sample file does not exist"
      return
    end

    res.body = File.read(file)
  end)

  server.mount_proc("/result.pdf", ->(_, res) do
    dir = "tmp"

    file = File.join(dir, "result.pdf")
    if !File.exist?(file)
      res.status = 404
      res.body = "The result file does not exist"
      return
    end

    res.body = File.read(file)
  end)

  trap("INT") do
    server.shutdown
  end

  server.start
end

main
