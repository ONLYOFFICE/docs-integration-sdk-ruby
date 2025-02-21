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
require_relative "conversion"

module Onlyoffice
  module DocsIntegrationSdk
    module DocumentServer
      class Client
        class ConversionService
          class ErrorTest < ::Test::Unit::TestCase
            extend T::Sig
            include Test::DescriptiveEnumMarshalling

            sig {override.returns(T::Array[[Integer, String, Error]])}
            def cases
              [
                [
                  -1,
                  "Unknown error",
                  Error::UnknownError,
                ],
                [
                  -2,
                  "Conversion timeout error",
                  Error::ConversionTimeout,
                ],
                [
                  -3,
                  "Conversion error",
                  Error::ConversionError,
                ],
                [
                  -4,
                  "Error while downloading the document file to be converted",
                  Error::DownloadError,
                ],
                [
                  -5,
                  "Incorrect password",
                  Error::IncorrectPassword,
                ],
                [
                  -6,
                  "Error while accessing the conversion result database",
                  Error::DatabaseError,
                ],
                [
                  -7,
                  "Input error",
                  Error::InputError,
                ],
                [
                  -8,
                  "Invalid token",
                  Error::InvalidToken,
                ],
                [
                  -9,
                  "The converter cannot automatically determine the output file format",
                  Error::UnknownFormat,
                ],
                [
                  -10,
                  "Size limit exceeded",
                  Error::SizeLimitExceeded,
                ],
              ]
            end
          end

          class Request
            class DelimiterTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::BasicEnumMarshalling

              sig {override.returns(T::Array[[Integer, Delimiter]])}
              def cases
                [
                  [0, Delimiter::None],
                  [1, Delimiter::Tab],
                  [2, Delimiter::Semicolon],
                  [3, Delimiter::Colon],
                  [4, Delimiter::Comma],
                  [5, Delimiter::Space],
                ]
              end
            end

            class DocumentLayoutTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::StructMarshalling

              sig {override.returns(T::Array[[T.untyped, DocumentLayout]])}
              def cases
                [
                  [
                    {},
                    DocumentLayout.new,
                  ],
                  [
                    {
                      "drawPlaceHolders" => true,
                      "drawFormHighlight" => true,
                      "isPrint" => true,
                    },
                    DocumentLayout.new(
                      draw_place_holders: true,
                      draw_form_highlight: true,
                      is_print: true,
                    ),
                  ],
                ]
              end
            end

            class DocumentRenderer
              class TextAssociationTest < ::Test::Unit::TestCase
                extend T::Sig
                include Test::BasicEnumMarshalling

                sig {override.returns(T::Array[[String, TextAssociation]])}
                def cases
                  [
                    ["blockChar", TextAssociation::BlockChar],
                    ["blockLine", TextAssociation::BlockLine],
                    ["plainLine", TextAssociation::PlainLine],
                    ["plainParagraph", TextAssociation::PlainParagraph],
                  ]
                end
              end
            end

            class DocumentRendererTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::StructMarshalling

              sig {override.returns(T::Array[[T.untyped, DocumentRenderer]])}
              def cases
                [
                  [
                    {},
                    DocumentRenderer.new,
                  ],
                  [
                    {
                      "textAssociation" => "blockChar",
                    },
                    DocumentRenderer.new(
                      text_association: DocumentRenderer::TextAssociation::BlockChar,
                    ),
                  ],
                ]
              end
            end

            class PdfTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::StructMarshalling

              sig {override.returns(T::Array[[T.untyped, Pdf]])}
              def cases
                [
                  [
                    {},
                    Pdf.new,
                  ],
                  [
                    {
                      "form" => true,
                    },
                    Pdf.new(
                      form: true,
                    ),
                  ],
                ]
              end
            end

            class SpreadsheetLayout
              class MarginsTest < ::Test::Unit::TestCase
                extend T::Sig
                include Test::StructMarshalling

                sig {override.returns(T::Array[[T.untyped, Margins]])}
                def cases
                  [
                    [
                      {},
                      Margins.new,
                    ],
                    [
                      {
                        "bottom" => "1mm",
                        "left" => "1mm",
                        "right" => "1mm",
                        "top" => "1mm",
                      },
                      Margins.new(
                        bottom: "1mm",
                        left: "1mm",
                        right: "1mm",
                        top: "1mm",
                      ),
                    ],
                  ]
                end
              end

              class OrientationTest < ::Test::Unit::TestCase
                extend T::Sig
                include Test::BasicEnumMarshalling

                sig {override.returns(T::Array[[String, Orientation]])}
                def cases
                  [
                    ["landscape", Orientation::Landscape],
                    ["portrait", Orientation::Portrait],
                  ]
                end
              end

              class PageSizeTest < ::Test::Unit::TestCase
                extend T::Sig
                include Test::StructMarshalling

                sig {override.returns(T::Array[[T.untyped, PageSize]])}
                def cases
                  [
                    [
                      {},
                      PageSize.new,
                    ],
                    [
                      {
                        "height" => "1mm",
                        "width" => "1mm",
                      },
                      PageSize.new(
                        height: "1mm",
                        width: "1mm",
                      ),
                    ],
                  ]
                end
              end
            end

            class SpreadsheetLayoutTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::StructMarshalling

              sig {override.returns(T::Array[[T.untyped, SpreadsheetLayout]])}
              def cases
                [
                  [
                    {},
                    SpreadsheetLayout.new,
                  ],
                  [
                    {
                      "fitToHeight" => 1,
                      "fitToWidth" => 1,
                      "gridLines" => true,
                      "headings" => true,
                      "ignorePrintArea" => true,
                      "margins" => {
                        "bottom" => "1mm",
                      },
                      "orientation" => "landscape",
                      "pageSize" => {
                        "height" => "1mm",
                      },
                      "scale" => 1,
                    },
                    SpreadsheetLayout.new(
                      fit_to_height: 1,
                      fit_to_width: 1,
                      grid_lines: true,
                      headings: true,
                      ignore_print_area: true,
                      margins: SpreadsheetLayout::Margins.new(
                        bottom: "1mm",
                      ),
                      orientation: SpreadsheetLayout::Orientation::Landscape,
                      page_size: SpreadsheetLayout::PageSize.new(
                        height: "1mm",
                      ),
                      scale: 1,
                    ),
                  ],
                ]
              end
            end

            class Thumbnail
              class AspectTest < ::Test::Unit::TestCase
                extend T::Sig
                include Test::BasicEnumMarshalling

                sig {override.returns(T::Array[[Integer, Aspect]])}
                def cases
                  [
                    [0, Aspect::Stretch],
                    [1, Aspect::Keep],
                    [2, Aspect::Page],
                  ]
                end
              end
            end

            class ThumbnailTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::StructMarshalling

              sig {override.returns(T::Array[[T.untyped, Thumbnail]])}
              def cases
                [
                  [
                    {},
                    Thumbnail.new,
                  ],
                  [
                    {
                      "aspect" => 1,
                      "first" => true,
                      "height" => 1,
                      "width" => 1,
                    },
                    Thumbnail.new(
                      aspect: Thumbnail::Aspect::Keep,
                      first: true,
                      height: 1,
                      width: 1,
                    ),
                  ],
                ]
              end
            end
          end

          class RequestTest < ::Test::Unit::TestCase
            extend T::Sig
            include Test::StructMarshalling

            sig {override.returns(T::Array[[T.untyped, Request]])}
            def cases
              [
                [
                  {},
                  Request.new,
                ],
                [
                  {
                    "async" => false,
                    "codePage" => 1,
                    "delimiter" => 1,
                    "documentLayout" => {
                      "drawPlaceHolders" => true,
                    },
                    "documentRenderer" => {
                      "textAssociation" => "blockChar",
                    },
                    "filetype" => "docx",
                    "key" => "***",
                    "outputtype" => "pdf",
                    "password" => "***",
                    "pdf" => {
                      "form" => true,
                    },
                    "region" => "en",
                    "spreadsheetLayout" => {
                      "fitToHeight" => 1,
                    },
                    "thumbnail" => {
                      "aspect" => 1,
                    },
                    "title" => "Title",
                    "url" => "http://example.com/",
                  },
                  Request.new(
                    async: false,
                    code_page: 1,
                    delimiter: Request::Delimiter::Tab,
                    document_layout: Request::DocumentLayout.new(
                      draw_place_holders: true,
                    ),
                    document_renderer: Request::DocumentRenderer.new(
                      text_association: Request::DocumentRenderer::TextAssociation::BlockChar,
                    ),
                    filetype: "docx",
                    key: "***",
                    outputtype: "pdf",
                    password: "***",
                    pdf: Request::Pdf.new(
                      form: true,
                    ),
                    region: "en",
                    spreadsheet_layout: Request::SpreadsheetLayout.new(
                      fit_to_height: 1,
                    ),
                    thumbnail: Request::Thumbnail.new(
                      aspect: Request::Thumbnail::Aspect::Keep,
                    ),
                    title: "Title",
                    url: "http://example.com/",
                  ),
                ],
              ]
            end
          end
        end

        class ConversionServiceTest < ::Test::Unit::TestCase
          extend T::Sig
          include Test::DocumentServer::Client

          sig {returns(String)}
          def req_s
            '{"async":true}'
          end

          sig {returns(T::Hash[String, T.untyped])}
          def req_h
            {"async" => true}
          end

          sig {returns(ConversionService::Request)}
          def req_o
            req = ConversionService::Request.new(async: true)
          end

          sig {returns(String)}
          def res_s
            '{"endConvert":"true"}'
          end

          sig {returns(ConversionService::Result)}
          def res_o
            ConversionService::Result.new(end_convert: true)
          end

          def test_do_does
            t = self

            m = "POST"
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            p = T.cast(URI.join(u.to_s, "ConvertService.ashx"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, p, req)
              t.check_request_headers_with_content_type(m, u, req)
              t.assert_equal(t.req_s, req.body)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok(t.res_s)
            end

            c = Client.new(base_uri: u, http: h)

            con, res = c.conversion.do(req_o)
            assert_nil(res.error)

            assert_equal(res_s, res.response.body)
            # todo: assert_equal(res_o, con)
          end

          def test_do_does_with_the_subpath
            t = self

            m = "POST"
            u = T.cast(URI.parse("http://localhost:8080/sub/"), URI::HTTP)
            p = T.cast(URI.join(u.to_s, "ConvertService.ashx"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, p, req)
              t.check_request_headers_with_content_type(m, u, req)
              t.assert_equal(t.req_s, req.body)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok(t.res_s)
            end

            c = Client.new(base_uri: u, http: h)

            con, res = c.conversion.do(req_o)
            assert_nil(res.error)

            assert_equal(res_s, res.response.body)
            # todo: assert_equal(res_o, con)
          end

          def test_do_does_with_the_user_agent
            t = self

            m = "POST"
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            p = T.cast(URI.join(u.to_s, "ConvertService.ashx"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, p, req)
              t.check_request_headers_with_content_type_and_custom_user_agent(m, u, "my-agent", req)
              t.assert_equal(t.req_s, req.body)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok(t.res_s)
            end

            c = Client.new(base_uri: u, http: h, user_agent: "my-agent")

            con, res = c.conversion.do(req_o)
            assert_nil(res.error)

            assert_equal(res_s, res.response.body)
            # todo: assert_equal(res_o, con)
          end

          def test_do_does_with_the_jwt
            t = self

            w = DocsIntegrationSdk::Jwt.new(secret: "***")
            m = "POST"
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            p = T.cast(URI.join(u.to_s, "ConvertService.ashx"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, p, req)
              t.check_request_headers_with_jwt(m, u, w, t.req_h, req)
              t.check_request_body_with_jwt(w, t.req_h, req)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok(t.res_s)
            end

            j = Jwt.new(jwt: w)
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            con, res = c.conversion.do(req_o)
            assert_nil(res.error)

            assert_equal(res_s, res.response.body)
            # todo: assert_equal(res_o, con)
          end

          def test_do_returns_an_error_if_the_response_body_is_invalid_json
            t = self

            m = "POST"
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            p = T.cast(URI.join(u.to_s, "ConvertService.ashx"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, p, req)
              t.check_request_headers_with_content_type(m, u, req)
              t.assert_equal(t.req_s, req.body)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok("}")
            end

            c = Client.new(base_uri: u, http: h)

            con, res = c.conversion.do(req_o)

            err = T.cast(res.error, JSON::ParserError)
            assert_equal("unexpected token at '}'", err.message)

            assert_equal("}", res.response.body)
            # todo: assert_equal(ConversionService::Result.new, con)
          end

          def test_do_returns_an_error_if_the_doing_fails
            for v in ConversionService::Error.values
              t = self

              m = "POST"
              u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
              p = T.cast(URI.join(u.to_s, "ConvertService.ashx"), URI::HTTP)
              h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

              h.define_singleton_method(:request) do |req, body = nil, &block|
                t.check_request_basics(m, p, req)
                t.check_request_headers_with_content_type(m, u, req)
                t.assert_equal(t.req_s, req.body)
                t.assert_nil(body)
                t.assert_nil(block)
                t.create_ok("{\"error\":#{v.serialize}}")
              end

              c = Client.new(base_uri: u, http: h)

              con, res = c.conversion.do(req_o)
              assert_equal(v, res.error)

              assert_equal("{\"error\":#{v.serialize}}", res.response.body)
              # todo: assert_equal(ConversionService::Result.new, con)
            end
          end

          def test_do_returns_an_error_if_the_doing_fails_with_an_unknown_error
            t = self

            m = "POST"
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            p = T.cast(URI.join(u.to_s, "ConvertService.ashx"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, p, req)
              t.check_request_headers_with_content_type(m, u, req)
              t.assert_equal(t.req_s, req.body)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok('{"error":9999}')
            end

            c = Client.new(base_uri: u, http: h)

            con, res = c.conversion.do(req_o)

            err = T.cast(res.error, KeyError)
            assert_equal("Enum Onlyoffice::DocsIntegrationSdk::DocumentServer::Client::ConversionService::Error key not found: 9999", err.message)

            assert_equal('{"error":9999}', res.response.body)
            # todo: assert_equal(ConversionService::Result.new, con)
          end

          def test_do_ignores_unknown_keys_in_the_response
            t = self

            m = "POST"
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            p = T.cast(URI.join(u.to_s, "ConvertService.ashx"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, p, req)
              t.check_request_headers_with_content_type(m, u, req)
              t.assert_equal(t.req_s, req.body)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok('{"unknown":true}')
            end

            c = Client.new(base_uri: u, http: h)

            con, res = c.conversion.do(req_o)
            assert_nil(res.error)

            assert_equal('{"unknown":true}', res.response.body)
            # todo: assert_equal(ConversionService::Result.new, con)
          end
        end
      end
    end
  end
end
