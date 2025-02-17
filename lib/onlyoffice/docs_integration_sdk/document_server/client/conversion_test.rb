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

require_relative "conversion"

module Onlyoffice
  module DocsIntegrationSdk
    module DocumentServer
      class Client
        class ConversionService
          class ErrorTest < Test::Unit::TestCase
            extend T::Sig

            sig {returns(T::Array[[Integer, String, Error]])}
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

            def test_serialize_serializes
              for v, _, c in cases
                assert_equal(v, c.serialize)
              end
            end

            def test_from_serialized_deserializes
              for v, _, c in cases
                assert_equal(c, Error.from_serialized(v))
              end
            end

            def test_description_returns_the_description
              for _, d, c in cases
                assert_equal(d, c.description)
              end
            end
          end

          class Request
            class DelimiterTest < Test::Unit::TestCase
              extend T::Sig

              sig {returns(T::Array[[Integer, Delimiter]])}
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

              def test_serialize_serializes
                for v, c in cases
                  assert_equal(v, c.serialize)
                end
              end

              def test_from_serialized_deserializes
                for v, c in cases
                  assert_equal(c, Delimiter.from_serialized(v))
                end
              end
            end

            class DocumentLayoutTest < Test::Unit::TestCase
              extend T::Sig

              sig {returns(T::Array[[T.untyped, DocumentLayout]])}
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

              def test_serialize_serializes
                for h, c in cases
                  assert_equal(h, c.serialize)
                end
              end

              def test_from_hash_deserializes
                omit("The == method is not implemented for DocumentLayout")

                for h, c in cases
                  assert_equal(c, DocumentLayout.from_hash(h))
                end
              end
            end

            class DocumentRenderer
              class TextAssociationTest < Test::Unit::TestCase
                extend T::Sig

                sig {returns(T::Array[[String, TextAssociation]])}
                def cases
                  [
                    ["blockChar", TextAssociation::BlockChar],
                    ["blockLine", TextAssociation::BlockLine],
                    ["plainLine", TextAssociation::PlainLine],
                    ["plainParagraph", TextAssociation::PlainParagraph],
                  ]
                end

                def test_serialize_serializes
                  for v, c in cases
                    assert_equal(v, c.serialize)
                  end
                end

                def test_from_serialized_deserializes
                  for v, c in cases
                    assert_equal(c, TextAssociation.from_serialized(v))
                  end
                end
              end
            end

            class DocumentRendererTest < Test::Unit::TestCase
              extend T::Sig

              sig {returns(T::Array[[T.untyped, DocumentRenderer]])}
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

              def test_serialize_serializes
                for h, c in cases
                  assert_equal(h, c.serialize)
                end
              end

              def test_from_hash_deserializes
                omit("The == method is not implemented for DocumentRenderer")

                for h, c in cases
                  assert_equal(c, DocumentRenderer.from_hash(h))
                end
              end
            end

            class PdfTest < Test::Unit::TestCase
              extend T::Sig

              sig {returns(T::Array[[T.untyped, Pdf]])}
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

              def test_serialize_serializes
                for h, c in cases
                  assert_equal(h, c.serialize)
                end
              end

              def test_from_hash_deserializes
                omit("The == method is not implemented for Pdf")

                for h, c in cases
                  assert_equal(c, Pdf.from_hash(h))
                end
              end
            end

            class SpreadsheetLayout
              class MarginsTest < Test::Unit::TestCase
                extend T::Sig

                sig {returns(T::Array[[T.untyped, Margins]])}
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

                def test_serialize_serializes
                  for h, c in cases
                    assert_equal(h, c.serialize)
                  end
                end

                def test_from_hash_deserializes
                  omit("The == method is not implemented for Margins")

                  for h, c in cases
                    assert_equal(c, Margins.from_hash(h))
                  end
                end
              end

              class OrientationTest < Test::Unit::TestCase
                extend T::Sig

                sig {returns(T::Array[[String, Orientation]])}
                def cases
                  [
                    ["landscape", Orientation::Landscape],
                    ["portrait", Orientation::Portrait],
                  ]
                end

                def test_serialize_serializes
                  for v, c in cases
                    assert_equal(v, c.serialize)
                  end
                end

                def test_from_serialized_deserializes
                  for v, c in cases
                    assert_equal(c, Orientation.from_serialized(v))
                  end
                end
              end

              class PageSizeTest < Test::Unit::TestCase
                extend T::Sig

                sig {returns(T::Array[[T.untyped, PageSize]])}
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

                def test_serialize_serializes
                  for h, c in cases
                    assert_equal(h, c.serialize)
                  end
                end

                def test_from_hash_deserializes
                  omit("The == method is not implemented for PageSize")

                  for h, c in cases
                    assert_equal(c, PageSize.from_hash(h))
                  end
                end
              end
            end

            class SpreadsheetLayoutTest < Test::Unit::TestCase
              extend T::Sig

              sig {returns(T::Array[[T.untyped, SpreadsheetLayout]])}
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

              def test_serialize_serializes
                for h, c in cases
                  assert_equal(h, c.serialize)
                end
              end

              def test_from_hash_deserializes
                omit("The == method is not implemented for SpreadsheetLayout")

                for h, c in cases
                  assert_equal(c, SpreadsheetLayout.from_hash(h))
                end
              end
            end

            class Thumbnail
              class AspectTest < Test::Unit::TestCase
                extend T::Sig

                sig {returns(T::Array[[Integer, Aspect]])}
                def cases
                  [
                    [0, Aspect::Stretch],
                    [1, Aspect::Keep],
                    [2, Aspect::Page],
                  ]
                end

                def test_serialize_serializes
                  for v, c in cases
                    assert_equal(v, c.serialize)
                  end
                end

                def test_from_serialized_deserializes
                  for v, c in cases
                    assert_equal(c, Aspect.from_serialized(v))
                  end
                end
              end
            end

            class ThumbnailTest < Test::Unit::TestCase
              extend T::Sig

              sig {returns(T::Array[[T.untyped, Thumbnail]])}
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

              def test_serialize_serializes
                for h, c in cases
                  assert_equal(h, c.serialize)
                end
              end

              def test_from_hash_deserializes
                omit("The == method is not implemented for Thumbnail")

                for h, c in cases
                  assert_equal(c, Thumbnail.from_hash(h))
                end
              end
            end
          end

          class RequestTest < Test::Unit::TestCase
            extend T::Sig

            sig {returns(T::Array[[T.untyped, Request]])}
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

            def test_serialize_serializes
              for c in cases
                assert_equal(c[0], c[1].serialize)
              end
            end

            def test_from_hash_deserializes
              omit("The == method is not implemented for Request")

              for c in cases
                assert_equal(c[1], Request.from_hash(c[0]))
              end
            end
          end
        end

        class ConversionServiceTest < Test::Unit::TestCase
          extend T::Sig

          def test_do_does
            c = ClientTest.client
            m, e = endpoint(c)
            h = ClientTest.headers_with_content_type(c, m)

            WebMock.stub_request(m.downcase.to_sym, e).
              with(headers: h, body: {"async" => true}).
              to_return(body: '{"endConvert":true}')

            req = ConversionService::Request.new(async: true)

            con, res = c.conversion.do(req)
            assert_nil(res.error)

            assert_equal(m, res.request.method)
            assert_equal(e, res.request.uri)
            assert_equal(h, res.request.to_hash)
            assert_equal('{"async":true}', res.request.body)

            assert_equal('{"endConvert":true}', res.response.body)

            # assert_equal(
            #   ConversionService::Result.new(
            #     end_convert: true,
            #   ),
            #   con,
            # )
          end

          def test_do_does_with_a_subpath
            c = ClientTest.client_with_a_subpath
            m, e = endpoint(c)
            h = ClientTest.headers_with_content_type(c, m)

            WebMock.stub_request(m.downcase.to_sym, e).
              with(headers: h, body: {"async" => true}).
              to_return(body: '{"endConvert":true}')

            req = ConversionService::Request.new(async: true)

            con, res = c.conversion.do(req)
            assert_nil(res.error)

            assert_equal(m, res.request.method)
            assert_equal(e, res.request.uri)
            assert_equal(h, res.request.to_hash)
            assert_equal('{"async":true}', res.request.body)

            assert_equal('{"endConvert":true}', res.response.body)

            # assert_equal(
            #   ConversionService::Result.new(
            #     end_convert: true,
            #   ),
            #   con,
            # )
          end

          def test_exec_executes_with_a_user_agent
            c = ClientTest.client_with_a_user_agent
            m, e = endpoint(c)
            h = ClientTest.headers_with_content_type(c, m)

            WebMock.stub_request(m.downcase.to_sym, e).
              with(headers: h, body: {"async" => true}).
              to_return(body: '{"endConvert":true}')

            req = ConversionService::Request.new(async: true)

            con, res = c.conversion.do(req)
            assert_nil(res.error)

            assert_equal(m, res.request.method)
            assert_equal(e, res.request.uri)
            assert_equal(h, res.request.to_hash)
            assert_equal('{"async":true}', res.request.body)

            assert_equal('{"endConvert":true}', res.response.body)

            # assert_equal(
            #   ConversionService::Result.new(
            #     end_convert: true,
            #   ),
            #   con,
            # )
          end

          def test_exec_executes_with_a_jwt
            c = ClientTest.client_with_a_jwt
            m, e = endpoint(c)
            h = ClientTest.headers_with_content_type(c, m)

            WebMock.stub_request(m.downcase.to_sym, e).
              with(headers: h, body: /.+/).
              to_return(body: '{"endConvert":true}')

            req = ConversionService::Request.new(async: true)

            con, res = c.conversion.do(req)
            assert_nil(res.error)

            assert_equal(m, res.request.method)
            assert_equal(e, res.request.uri)
            # assert_equal(h, res.request.to_hash)
            # assert_equal('{"async":true}', res.request.body)

            assert_equal('{"endConvert":true}', res.response.body)

            # assert_equal(
            #   ConversionService::Result.new(
            #     end_convert: true,
            #   ),
            #   con,
            # )
          end

          def test_do_returns_an_error_if_the_response_body_is_invalid_json
            c = ClientTest.client_with_a_user_agent
            m, e = endpoint(c)
            h = ClientTest.headers_with_content_type(c, m)

            WebMock.stub_request(m.downcase.to_sym, e).
              with(headers: h, body: {"async" => true}).
              to_return(body: "}")

            req = ConversionService::Request.new(async: true)

            con, res = c.conversion.do(req)

            err = T.cast(res.error, JSON::ParserError)
            assert_equal("unexpected token at '}'", err.message)

            assert_equal(m, res.request.method)
            assert_equal(e, res.request.uri)
            assert_equal(h, res.request.to_hash)
            assert_equal('{"async":true}', res.request.body)

            assert_equal("}", res.response.body)

            # assert_equal(
            #   ConversionService::Result.new(),
            #   con,
            # )
          end

          def test_do_returns_an_error_if_the_doing_fails
            for v in ConversionService::Error.values
              c = ClientTest.client_with_a_user_agent
              m, e = endpoint(c)
              h = ClientTest.headers_with_content_type(c, m)

              WebMock.stub_request(m.downcase.to_sym, e).
                with(headers: h, body: {"async" => true}).
                to_return(body: "{\"error\":#{v.serialize}}")

              req = ConversionService::Request.new(async: true)

              con, res = c.conversion.do(req)
              assert_equal(v, res.error)

              assert_equal(m, res.request.method)
              assert_equal(e, res.request.uri)
              assert_equal(h, res.request.to_hash)
              assert_equal('{"async":true}', res.request.body)

              assert_equal("{\"error\":#{v.serialize}}", res.response.body)

              # assert_equal(
              #   ConversionService::Result.new(),
              #   con,
              # )
            end
          end

          def test_do_returns_an_error_if_the_doing_fails_with_an_unknown_error
            c = ClientTest.client_with_a_user_agent
            m, e = endpoint(c)
            h = ClientTest.headers_with_content_type(c, m)

            WebMock.stub_request(m.downcase.to_sym, e).
              with(headers: h, body: {"async" => true}).
              to_return(body: '{"error":9999}')

            req = ConversionService::Request.new(async: true)

            con, res = c.conversion.do(req)

            err = T.cast(res.error, KeyError)
            assert_equal("Enum Onlyoffice::DocsIntegrationSdk::DocumentServer::Client::ConversionService::Error key not found: 9999", err.message)

            assert_equal(m, res.request.method)
            assert_equal(e, res.request.uri)
            assert_equal(h, res.request.to_hash)
            assert_equal('{"async":true}', res.request.body)

            assert_equal('{"error":9999}', res.response.body)

            # assert_equal(
            #   ConversionService::Result.new(),
            #   con,
            # )
          end

          def test_do_ignores_unknown_keys_in_the_response
            c = ClientTest.client_with_a_user_agent
            m, e = endpoint(c)
            h = ClientTest.headers_with_content_type(c, m)

            WebMock.stub_request(m.downcase.to_sym, e).
              with(headers: h, body: {"async" => true}).
              to_return(body: '{"unknown":true}')

            req = ConversionService::Request.new(async: true)

            con, res = c.conversion.do(req)
            assert_nil(res.error)

            assert_equal(m, res.request.method)
            assert_equal(e, res.request.uri)
            assert_equal(h, res.request.to_hash)
            assert_equal('{"async":true}', res.request.body)

            assert_equal('{"unknown":true}', res.response.body)

            # assert_equal(
            #   ConversionService::Result.new(),
            #   con,
            # )
          end

          sig {params(c: Client).returns([String, URI::HTTP])}
          def endpoint(c)
            ["POST", T.cast(URI.join(c.base_uri, "ConvertService.ashx"), URI::HTTP)]
          end
        end
      end
    end
  end
end
