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
require_relative "command"

module Onlyoffice
  module DocsIntegrationSdk
    module DocumentServer
      class Client
        class CommandService
          class ErrorTest < ::Test::Unit::TestCase
            extend T::Sig
            include Test::DescriptiveEnumMarshalling

            sig {override.returns(T::Array[[Integer, String, Error]])}
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
          end

          class Request
            class CTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::BasicEnumMarshalling

              sig {override.returns(T::Array[[String, C]])}
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
            end

            class LicenseTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::StructMarshalling

              sig {override.returns(T::Array[[T.untyped, License]])}
              def cases
                [
                  [
                    {},
                    License.new,
                  ],
                  [
                    {
                      "end_date" => "2025-01-01",
                      "trial" => true,
                      "customization" => true,
                      "connections" => 10,
                      "connections_view" => 10,
                      "users_count" => 10,
                      "users_view_count" => 10,
                      "users_expire" => 10,
                    },
                    License.new(
                      end_date: "2025-01-01",
                      trial: true,
                      customization: true,
                      connections: 10,
                      connections_view: 10,
                      users_count: 10,
                      users_view_count: 10,
                      users_expire: 10,
                    ),
                  ],
                ]
              end
            end

            class Server
              class ResultTypeTest < ::Test::Unit::TestCase
                extend T::Sig
                include Test::DescriptiveEnumMarshalling

                sig {override.returns(T::Array[[Integer, String, ResultType]])}
                def cases
                  [
                    [
                      1,
                      "An error occurred",
                      ResultType::Error,
                    ],
                    [
                      2,
                      "The license expired",
                      ResultType::LicenseExpired,
                    ],
                    [
                      3,
                      "The license is still available",
                      ResultType::LicenseAvailable,
                    ],
                    [
                      6,
                      "The trial license expired",
                      ResultType::TrialLicenseExpired,
                    ],
                  ]
                end
              end

              class PackageTypeTest < ::Test::Unit::TestCase
                extend T::Sig
                include Test::BasicEnumMarshalling

                sig {override.returns(T::Array[[Integer, PackageType]])}
                def cases
                  [
                    [0, PackageType::OpenSource],
                    [1, PackageType::Enterprise],
                    [2, PackageType::Developer],
                  ]
                end
              end
            end

            class ServerTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::StructMarshalling

              sig {override.returns(T::Array[[T.untyped, Server]])}
              def cases
                [
                  [
                    {},
                    Server.new,
                  ],
                  [
                    {
                      "resultType" => 1,
                      "packageType" => 1,
                      "buildDate" => "2025-01-01",
                      "buildVersion" => "1.0",
                      "buildNumber" => 1,
                    },
                    Server.new(
                      result_type: Server::ResultType::Error,
                      package_type: Server::PackageType::Enterprise,
                      build_date: "2025-01-01",
                      build_version: "1.0",
                      build_number: 1,
                    ),
                  ],
                ]
              end
            end

            class Quota
              class UserTest < ::Test::Unit::TestCase
                extend T::Sig
                include Test::StructMarshalling

                sig {override.returns(T::Array[[T.untyped, User]])}
                def cases
                  [
                    [
                      {},
                      User.new,
                    ],
                    [
                      {
                        "userid" => "user_1",
                        "expire" => "2025-01-01",
                      },
                      User.new(
                        userid: "user_1",
                        expire: "2025-01-01",
                      ),
                    ],
                  ]
                end
              end
            end

            class QuotaTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::StructMarshalling

              sig {override.returns(T::Array[[T.untyped, Quota]])}
              def cases
                [
                  [
                    {},
                    Quota.new,
                  ],
                  [
                    {
                      "users" => [
                        {
                          "userid" => "user_1",
                        },
                      ],
                      "users_view" => [
                        {
                          "userid" => "user_1",
                        },
                      ],
                    },
                    Quota.new(
                      users: [
                        Quota::User.new(
                          userid: "user_1",
                        ),
                      ],
                      users_view: [
                        Quota::User.new(
                          userid: "user_1",
                        ),
                      ],
                    ),
                  ],
                ]
              end
            end

            class MetaTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::StructMarshalling

              sig {override.returns(T::Array[[T.untyped, Meta]])}
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
                    "c" => "deleteForgotten",
                    "key" => "***",
                    "users" => ["User 1", "User 2"],
                    "userdata" => "Data",
                    "license" => {
                      "end_date" => "2025-01-01",
                    },
                    "server" => {
                      "resultType" => 1,
                    },
                    "quota" => {
                      "users" => [],
                    },
                    "meta" => {
                      "title" => "Title",
                    },
                  },
                  Request.new(
                    c: Request::C::DeleteForgotten,
                    key: "***",
                    users: ["User 1", "User 2"],
                    userdata: "Data",
                    license: Request::License.new(
                      end_date: "2025-01-01",
                    ),
                    server: Request::Server.new(
                      result_type: Request::Server::ResultType::Error,
                    ),
                    quota: Request::Quota.new(
                      users: [],
                    ),
                    meta: Request::Meta.new(
                      title: "Title",
                    ),
                  ),
                ],
              ]
            end
          end

          class ResultTest < ::Test::Unit::TestCase
            extend T::Sig
            include Test::StructMarshalling

            sig {override.returns(T::Array[[T.untyped, Result]])}
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
          end
        end

        class CommandServiceTest < ::Test::Unit::TestCase
          extend T::Sig
          include Test::DocumentServer::Client

          sig {returns(String)}
          def req_s
            '{"c":"info"}'
          end

          sig {returns(T::Hash[String, T.untyped])}
          def req_h
            {"c" => "info"}
          end

          sig {returns(CommandService::Request)}
          def req_o
            req = CommandService::Request.new(
              c: CommandService::Request::C::Info,
            )
          end

          sig {returns(String)}
          def res_s
            '{"key":"***"}'
          end

          sig {returns(CommandService::Result)}
          def res_o
            CommandService::Result.new(
              key: "***",
            )
          end

          def test_do_does
            t = self

            m = "POST"
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            p = T.cast(URI.join(u.to_s, "coauthoring/CommandService.ashx"), URI::HTTP)
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

            com, res = c.command.do(req_o)
            assert_nil(res.error)

            assert_equal(res_s, res.response.body)
            # todo: assert_equal(res_o, com)
          end

          def test_do_does_with_the_subpath
            t = self

            m = "POST"
            u = T.cast(URI.parse("http://localhost:8080/sub/"), URI::HTTP)
            p = T.cast(URI.join(u.to_s, "coauthoring/CommandService.ashx"), URI::HTTP)
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

            com, res = c.command.do(req_o)
            assert_nil(res.error)

            assert_equal(res_s, res.response.body)
            # todo: assert_equal(res_o, com)
          end

          def test_do_does_with_the_user_agent
            t = self

            m = "POST"
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            p = T.cast(URI.join(u.to_s, "coauthoring/CommandService.ashx"), URI::HTTP)
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

            com, res = c.command.do(req_o)
            assert_nil(res.error)

            assert_equal(res_s, res.response.body)
            # todo: assert_equal(res_o, com)
          end

          def test_do_does_with_the_jwt
            t = self

            w = DocsIntegrationSdk::Jwt.new(secret: "***")
            m = "POST"
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            p = T.cast(URI.join(u.to_s, "coauthoring/CommandService.ashx"), URI::HTTP)
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

            com, res = c.command.do(req_o)
            assert_nil(res.error)

            assert_equal(res_s, res.response.body)
            # todo: assert_equal(res_o, com)
          end

          def test_do_returns_an_error_if_the_response_body_is_invalid_json
            t = self

            m = "POST"
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            p = T.cast(URI.join(u.to_s, "coauthoring/CommandService.ashx"), URI::HTTP)
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

            com, res = c.command.do(req_o)

            err = T.cast(res.error, JSON::ParserError)
            assert_equal("unexpected token at '}'", err.message)

            assert_equal("}", res.response.body)
            # todo: assert_equal(CommandService::Result.new, com)
          end

          def test_do_returns_an_error_if_the_doing_fails
            for v in CommandService::Error.values
              if v == CommandService::Error::None
                next
              end

              t = self

              m = "POST"
              u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
              p = T.cast(URI.join(u.to_s, "coauthoring/CommandService.ashx"), URI::HTTP)
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

              com, res = c.command.do(req_o)
              assert_equal(v, res.error)

              assert_equal("{\"error\":#{v.serialize}}", res.response.body)
              # todo: assert_equal(CommandService::Result.new, com)
            end
          end

          def test_do_returns_an_error_if_the_doing_fails_with_an_unknown_error
            t = self

            m = "POST"
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            p = T.cast(URI.join(u.to_s, "coauthoring/CommandService.ashx"), URI::HTTP)
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

            com, res = c.command.do(req_o)

            err = T.cast(res.error, KeyError)
            assert_equal("Enum Onlyoffice::DocsIntegrationSdk::DocumentServer::Client::CommandService::Error key not found: 9999", err.message)

            assert_equal('{"error":9999}', res.response.body)
            # todo: assert_equal(CommandService::Result.new, com)
          end

          def test_do_ignores_the_error_if_it_is_none
            t = self

            m = "POST"
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            p = T.cast(URI.join(u.to_s, "coauthoring/CommandService.ashx"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, p, req)
              t.check_request_headers_with_content_type(m, u, req)
              t.assert_equal(t.req_s, req.body)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok('{"error":0,"key":"***"}')
            end

            c = Client.new(base_uri: u, http: h)

            com, res = c.command.do(req_o)
            assert_nil(res.error)

            assert_equal('{"error":0,"key":"***"}', res.response.body)
            # todo: assert_equal(CommandService::Result.new, com)
          end

          def test_do_ignores_unknown_keys_in_the_response
            t = self

            m = "POST"
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            p = T.cast(URI.join(u.to_s, "coauthoring/CommandService.ashx"), URI::HTTP)
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

            com, res = c.command.do(req_o)
            assert_nil(res.error)

            assert_equal('{"unknown":true}', res.response.body)
            # todo: assert_equal(CommandService::Result.new, com)
          end
        end
      end
    end
  end
end
