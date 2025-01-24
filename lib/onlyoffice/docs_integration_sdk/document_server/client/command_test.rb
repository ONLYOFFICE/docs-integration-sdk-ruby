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

require_relative "command"

module Onlyoffice
  module DocsIntegrationSdk
    module DocumentServer
      class Client
        class CommandService
          class ErrorTest < Test::Unit::TestCase
            extend T::Sig

            sig {returns(T::Array[[Integer, String, Error]])}
            def cases
              [
                [
                  0,
                  "No errors",
                  Error::None,
                ],
                [
                  1,
                  "Document key is missing or no document with such key could be found",
                  Error::MissingDocumentKey,
                ],
                [
                  2,
                  "Callback url not correct",
                  Error::IncorrectCallbackUrl,
                ],
                [
                  3,
                  "Internal server error",
                  Error::InternalError,
                ],
                [
                  4,
                  "No changes were applied to the document before the forcesave command was received",
                  Error::NoChanges,
                ],
                [
                  5,
                  "Command not correct",
                  Error::IncorrectCommand,
                ],
                [
                  6,
                  "Invalid token",
                  Error::InvalidToken,
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
            class CTest < Test::Unit::TestCase
              extend T::Sig

              sig {returns(T::Array[[String, C]])}
              def cases
                [
                  ["deleteForgotten", C::DeleteForgotten],
                  ["drop", C::Drop],
                  ["forcesave", C::Forcesave],
                  ["getForgotten", C::GetForgotten],
                  ["getForgottenList", C::GetForgottenList],
                  ["info", C::Info],
                  ["license", C::License],
                  ["meta", C::Meta],
                  ["version", C::Version],
                ]
              end

              def test_serialize_serializes
                for v, c in cases
                  assert_equal(v, c.serialize)
                end
              end

              def test_from_serialized_deserializes
                for v, c in cases
                  assert_equal(c, C.from_serialized(v))
                end
              end
            end

            class MetaTest < Test::Unit::TestCase
              extend T::Sig

              sig {returns(T::Array[[T.untyped, Meta]])}
              def cases
                [
                  [
                    {},
                    Meta.new,
                  ],
                  [
                    {
                      "title" => "Title",
                    },
                    Meta.new(
                      title: "Title",
                    ),
                  ],
                ]
              end

              def test_serialize_serializes
                for v, c in cases
                  assert_equal(v, c.serialize)
                end
              end

              def test_from_hash_deserializes
                omit("The == method is not implemented for Meta")

                for v, c in cases
                  assert_equal(c, Meta.from_hash(v))
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
                    "c" => "deleteForgotten",
                    "key" => "***",
                    "users" => ["User 1", "User 2"],
                    "userdata" => "Data",
                    "license" => {},
                    "server" => {},
                    "quota" => {},
                    "meta" => {
                      "title" => "Title",
                    },
                  },
                  Request.new(
                    c: Request::C::DeleteForgotten,
                    key: "***",
                    users: ["User 1", "User 2"],
                    userdata: "Data",
                    license: Request::License.new,
                    server: Request::Server.new,
                    quota: Request::Quota.new,
                    meta: Request::Meta.new(
                      title: "Title",
                    ),
                  ),
                ],
              ]
            end

            def test_serialize_serializes
              for v, c in cases
                assert_equal(v, c.serialize)
              end
            end

            def test_from_hash_deserializes
              omit("The == method is not implemented for Request")

              for v, c in cases
                assert_equal(c, Request.from_hash(v))
              end
            end
          end

          class ResultTest < Test::Unit::TestCase
            extend T::Sig

            sig {returns(T::Array[[T.untyped, Result]])}
            def cases
              [
                [
                  {},
                  Result.new,
                ],
                [
                  {
                    "key" => "***",
                    "url" => "http://example.com/",
                    "keys" => ["Key 1", "Key 2"],
                    "users" => ["User 1", "User 2"],
                    "version" => "1.0",
                  },
                  Result.new(
                    key: "***",
                    url: "http://example.com/",
                    keys: ["Key 1", "Key 2"],
                    users: ["User 1", "User 2"],
                    version: "1.0",
                  ),
                ],
              ]
            end

            def test_serialize_serializes
              for v, c in cases
                assert_equal(v, c.serialize)
              end
            end

            def test_from_hash_deserializes
              omit("The == method is not implemented for Result")

              for v, c in cases
                assert_equal(c, Result.from_hash(v))
              end
            end
          end
        end

        class CommandServiceTest < Test::Unit::TestCase
          extend T::Sig

          def test_do_does
            c = ClientTest.client
            m, e = endpoint(c)
            h = ClientTest.headers_with_content_type(c)

            WebMock.stub_request(m.downcase.to_sym, e).
              with(headers: h, body: {"c" => "info"}).
              to_return(body: '{"key":"***"}')

            req = CommandService::Request.new(
              c: CommandService::Request::C::Info,
            )

            com, res = c.command.do(req)
            assert_nil(res.error)

            assert_equal(m, res.request.method)
            assert_equal(e, res.request.uri)
            assert_equal(h, res.request.to_hash)
            assert_equal('{"c":"info"}', res.request.body)

            assert_equal('{"key":"***"}', res.response.body)

            # assert_equal(
            #   CommandService::Result.new(
            #     key: "***",
            #   ),
            #   com,
            # )
          end

          def test_do_does_with_a_subpath
            c = ClientTest.client_with_a_subpath
            m, e = endpoint(c)
            h = ClientTest.headers_with_content_type(c)

            WebMock.stub_request(m.downcase.to_sym, e).
              with(headers: h, body: {"c" => "info"}).
              to_return(body: '{"key":"***"}')

            req = CommandService::Request.new(
              c: CommandService::Request::C::Info,
            )

            com, res = c.command.do(req)
            assert_nil(res.error)

            assert_equal(m, res.request.method)
            assert_equal(e, res.request.uri)
            assert_equal(h, res.request.to_hash)
            assert_equal('{"c":"info"}', res.request.body)

            assert_equal('{"key":"***"}', res.response.body)

            # assert_equal(
            #   CommandService::Result.new(
            #     key: "***",
            #   ),
            #   com,
            # )
          end

          def test_do_does_with_a_user_agent
            c = ClientTest.client_with_a_user_agent
            m, e = endpoint(c)
            h = ClientTest.headers_with_content_type(c)

            WebMock.stub_request(m.downcase.to_sym, e).
              with(headers: h, body: {"c" => "info"}).
              to_return(body: '{"key":"***"}')

            req = CommandService::Request.new(
              c: CommandService::Request::C::Info,
            )

            com, res = c.command.do(req)
            assert_nil(res.error)

            assert_equal(m, res.request.method)
            assert_equal(e, res.request.uri)
            assert_equal(h, res.request.to_hash)
            assert_equal('{"c":"info"}', res.request.body)

            assert_equal('{"key":"***"}', res.response.body)

            # assert_equal(
            #   CommandService::Result.new(
            #     key: "***",
            #   ),
            #   com,
            # )
          end

          def test_do_does_with_a_jwt
            c = ClientTest.client_with_a_jwt
            m, e = endpoint(c)
            h = ClientTest.headers_with_content_type(c)

            WebMock.stub_request(m.downcase.to_sym, e).
              with(headers: h, body: /.+/).
              to_return(body: '{"key":"***"}')

            req = CommandService::Request.new(
              c: CommandService::Request::C::Info,
            )

            com, res = c.command.do(req)
            assert_nil(res.error)

            assert_equal(m, res.request.method)
            assert_equal(e, res.request.uri)
            # assert_equal(h, res.request.to_hash)
            # assert_equal('{"c":"info"}', res.request.body)

            assert_equal('{"key":"***"}', res.response.body)

            # assert_equal(
            #   CommandService::Result.new(
            #     key: "***",
            #   ),
            #   com,
            # )
          end

          def test_do_returns_an_error_if_the_response_body_is_invalid_json
            c = ClientTest.client
            m, e = endpoint(c)
            h = ClientTest.headers_with_content_type(c)

            WebMock.stub_request(m.downcase.to_sym, e).
              with(headers: h, body: {"c" => "info"}).
              to_return(body: "}")

            req = CommandService::Request.new(
              c: CommandService::Request::C::Info,
            )

            com, res = c.command.do(req)

            err = T.cast(res.error, JSON::ParserError)
            assert_equal("unexpected token at '}'", err.message)

            assert_equal(m, res.request.method)
            assert_equal(e, res.request.uri)
            assert_equal(h, res.request.to_hash)
            assert_equal('{"c":"info"}', res.request.body)

            assert_equal("}", res.response.body)

            # assert_equal(
            #   CommandService::Result.new(),
            #   com,
            # )
          end

          def test_do_returns_an_error_if_the_doing_fails
            for v in CommandService::Error.values
              if v == CommandService::Error::None
                next
              end

              c = ClientTest.client
              m, e = endpoint(c)
              h = ClientTest.headers_with_content_type(c)

              WebMock.stub_request(m.downcase.to_sym, e).
                with(headers: h, body: {"c" => "info"}).
                to_return(body: "{\"error\":#{v.serialize}}")

              req = CommandService::Request.new(
                c: CommandService::Request::C::Info,
              )

              com, res = c.command.do(req)
              assert_equal(v, res.error)

              assert_equal(m, res.request.method)
              assert_equal(e, res.request.uri)
              assert_equal(h, res.request.to_hash)
              assert_equal('{"c":"info"}', res.request.body)

              assert_equal("{\"error\":#{v.serialize}}", res.response.body)

              # assert_equal(
              #   CommandService::Result.new(),
              #   com,
              # )
            end
          end

          def test_do_returns_an_error_if_the_doing_fails_with_an_unknown_error
            c = ClientTest.client
            m, e = endpoint(c)
            h = ClientTest.headers_with_content_type(c)

            WebMock.stub_request(m.downcase.to_sym, e).
              with(headers: h, body: {"c" => "info"}).
              to_return(body: '{"error":9999}')

            req = CommandService::Request.new(
              c: CommandService::Request::C::Info,
            )

            com, res = c.command.do(req)

            err = T.cast(res.error, KeyError)
            assert_equal("Enum Onlyoffice::DocsIntegrationSdk::DocumentServer::Client::CommandService::Error key not found: 9999", err.message)

            assert_equal(m, res.request.method)
            assert_equal(e, res.request.uri)
            assert_equal(h, res.request.to_hash)
            assert_equal('{"c":"info"}', res.request.body)

            assert_equal('{"error":9999}', res.response.body)

            # assert_equal(
            #   CommandService::Result.new(),
            #   com,
            # )
          end

          def test_do_ignores_the_error_if_it_is_none
            c = ClientTest.client
            m, e = endpoint(c)
            h = ClientTest.headers_with_content_type(c)

            WebMock.stub_request(m.downcase.to_sym, e).
              with(headers: h, body: {"c" => "info"}).
              to_return(body: '{"error":0,"key":"***"}')

            req = CommandService::Request.new(
              c: CommandService::Request::C::Info,
            )

            com, res = c.command.do(req)
            assert_nil(res.error)

            assert_equal(m, res.request.method)
            assert_equal(e, res.request.uri)
            assert_equal(h, res.request.to_hash)
            assert_equal('{"c":"info"}', res.request.body)

            assert_equal('{"error":0,"key":"***"}', res.response.body)

            # assert_equal(
            #   CommandService::Result.new(),
            #   com,
            # )
          end

          def test_do_ignores_unknown_keys_in_the_response
            c = ClientTest.client
            m, e = endpoint(c)
            h = ClientTest.headers_with_content_type(c)

            WebMock.stub_request(:post, e).
              with(headers: h, body: {"c" => "info"}).
              to_return(body: '{"unknown":true}')

            req = CommandService::Request.new(
              c: CommandService::Request::C::Info,
            )

            com, res = c.command.do(req)
            assert_nil(res.error)

            assert_equal(m, res.request.method)
            assert_equal(e, res.request.uri)
            assert_equal(h, res.request.to_hash)
            assert_equal('{"c":"info"}', res.request.body)

            assert_equal('{"unknown":true}', res.response.body)

            # assert_equal(
            #   CommandService::Result.new(),
            #   com,
            # )
          end

          sig {params(c: Client).returns([String, URI::HTTP])}
          def endpoint(c)
            ["POST", T.cast(URI.join(c.base_uri.to_s, "coauthoring/CommandService.ashx"), URI::HTTP)]
          end
        end
      end
    end
  end
end
