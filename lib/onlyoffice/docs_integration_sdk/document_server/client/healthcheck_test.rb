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

# typed: true
# frozen_string_literal: true

require "test/unit"
require_relative "../../jwt"
require_relative "../../test_test"
require_relative "../client_test"
require_relative "healthcheck"

module Onlyoffice
  module DocsIntegrationSdk
    module DocumentServer
      class Client
        class HealthcheckService
          class ErrorTest < ::Test::Unit::TestCase
            extend T::Sig
            include Test::DescriptiveEnumMarshalling

            sig {override.returns(T::Array[[Integer, String, Error]])}
            def cases
              [
                [
                  -1,
                  "Healthcheck failed",
                  Error::Failed,
                ]
              ]
            end
          end
        end

        class HealthcheckServiceTest < ::Test::Unit::TestCase
          extend T::Sig
          include Test::DocumentServer::Client

          def test_do_does
            t = self

            m = "GET"
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            p = T.cast(URI.join(u.to_s, "healthcheck"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, p, req)
              t.check_request_headers(m, u, req)
              t.assert_nil(req.body)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok("true")
            end

            c = Client.new(base_uri: u, http: h)

            res = c.healthcheck.do
            assert_nil(res.error)

            assert_equal("true", res.response.body)
          end

          def test_do_does_with_the_subpath
            t = self

            m = "GET"
            u = T.cast(URI.parse("http://localhost:8080/sub/"), URI::HTTP)
            p = T.cast(URI.join(u.to_s, "healthcheck"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, p, req)
              t.check_request_headers(m, u, req)
              t.assert_nil(req.body)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok("true")
            end

            c = Client.new(base_uri: u, http: h)

            res = c.healthcheck.do
            assert_nil(res.error)

            assert_equal("true", res.response.body)
          end

          def test_do_does_with_the_user_agent
            t = self

            m = "GET"
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            p = T.cast(URI.join(u.to_s, "healthcheck"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, p, req)
              t.check_request_headers_with_custom_user_agent(m, u, "my-agent", req)
              t.assert_nil(req.body)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok("true")
            end

            c = Client.new(base_uri: u, http: h, user_agent: "my-agent")

            res = c.healthcheck.do
            assert_nil(res.error)

            assert_equal("true", res.response.body)
          end

          def test_do_does_with_the_jwt
            t = self

            w = DocsIntegrationSdk::Jwt.new(secret: "***")
            m = "GET"
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            p = T.cast(URI.join(u.to_s, "healthcheck"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, p, req)
              t.check_request_headers(m, u, req)
              t.assert_nil(req.body)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok("true")
            end

            j = Jwt.new(jwt: w)
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            res = c.healthcheck.do
            assert_nil(res.error)

            assert_equal("true", res.response.body)
          end

          def test_do_returns_an_error_if_the_response_body_is_invalid_json
            t = self

            m = "GET"
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            p = T.cast(URI.join(u.to_s, "healthcheck"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, p, req)
              t.check_request_headers(m, u, req)
              t.assert_nil(req.body)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok("}")
            end

            c = Client.new(base_uri: u, http: h)

            res = c.healthcheck.do

            err = T.cast(res.error, JSON::ParserError)
            assert_equal("unexpected token at '}'", err.message)

            assert_equal("}", res.response.body)
          end

          def test_do_returns_an_error_if_the_doing_fails
            t = self

            m = "GET"
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            p = T.cast(URI.join(u.to_s, "healthcheck"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, p, req)
              t.check_request_headers(m, u, req)
              t.assert_nil(req.body)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok("false")
            end

            c = Client.new(base_uri: u, http: h)

            res = c.healthcheck.do
            assert_equal(HealthcheckService::Error::Failed, res.error)

            assert_equal("false", res.response.body)
          end
        end
      end
    end
  end
end
