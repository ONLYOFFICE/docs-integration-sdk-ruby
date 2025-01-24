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

require_relative "healthcheck"

module Onlyoffice
  module DocsIntegrationSdk
    module DocumentServer
      class Client
        class HealthcheckService
          class ErrorTest < Test::Unit::TestCase
            extend T::Sig

            sig {returns(T::Array[[Integer, String, Error]])}
            def cases
              [
                [
                  -1,
                  "Healthcheck failed",
                  Error::Failed,
                ]
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
        end

        class HealthcheckServiceTest < Test::Unit::TestCase
          extend T::Sig

          def test_do_does
            c = ClientTest.client
            m, e = endpoint(c)
            h = ClientTest.headers(c)

            WebMock.stub_request(m.downcase.to_sym, e).
              with(headers: h).
              to_return(body: "true")

            res = c.healthcheck.do
            assert_nil(res.error)

            assert_equal(m, res.request.method)
            assert_equal(e, res.request.uri)
            assert_equal(h, res.request.to_hash)
            assert_nil(res.request.body)

            assert_equal("true", res.response.body)
          end

          def test_do_does_with_a_subpath
            c = ClientTest.client_with_a_subpath
            m, e = endpoint(c)
            h = ClientTest.headers(c)

            WebMock.stub_request(m.downcase.to_sym, e).
              with(headers: h).
              to_return(body: "true")

            res = c.healthcheck.do
            assert_nil(res.error)

            assert_equal(m, res.request.method)
            assert_equal(e, res.request.uri)
            assert_equal(h, res.request.to_hash)
            assert_nil(res.request.body)

            assert_equal("true", res.response.body)
          end

          def test_do_does_with_a_user_agent
            c = ClientTest.client_with_a_user_agent
            m, e = endpoint(c)
            h = ClientTest.headers(c)

            WebMock.stub_request(m.downcase.to_sym, e).
              with(headers: h).
              to_return(body: "true")

            res = c.healthcheck.do
            assert_nil(res.error)

            assert_equal(m, res.request.method)
            assert_equal(e, res.request.uri)
            assert_equal(h, res.request.to_hash)
            assert_nil(res.request.body)

            assert_equal("true", res.response.body)
          end

          def test_do_does_with_a_jwt
            c = ClientTest.client_with_a_jwt
            m, e = endpoint(c)
            h = ClientTest.headers(c)

            WebMock.stub_request(m.downcase.to_sym, e).
              with(headers: h).
              to_return(body: "true")

            res = c.healthcheck.do
            assert_nil(res.error)

            assert_equal(m, res.request.method)
            assert_equal(e, res.request.uri)
            # assert_equal(h, res.request.to_hash)
            assert_nil(res.request.body)

            assert_equal("true", res.response.body)
          end

          def test_do_returns_an_error_if_the_response_body_is_invalid_json
            c = ClientTest.client
            m, e = endpoint(c)
            h = ClientTest.headers(c)

            WebMock.stub_request(m.downcase.to_sym, e).
              with(headers: h).
              to_return(body: "}")

            res = c.healthcheck.do

            err = T.cast(res.error, JSON::ParserError)
            assert_equal("unexpected token at '}'", err.message)

            assert_equal("GET", res.request.method)
            assert_equal(e, res.request.uri)
            assert_equal(h, res.request.to_hash)
            assert_nil(res.request.body)

            assert_equal("}", res.response.body)
          end

          def test_do_returns_an_error_if_the_doing_fails
            c = ClientTest.client
            m, e = endpoint(c)
            h = ClientTest.headers(c)

            WebMock.stub_request(m.downcase.to_sym, e).
              with(headers: h).
              to_return(body: "false")

            res = c.healthcheck.do
            assert_equal(HealthcheckService::Error::Failed, res.error)

            assert_equal("GET", res.request.method)
            assert_equal(e, res.request.uri)
            assert_equal(h, res.request.to_hash)
            assert_nil(res.request.body)

            assert_equal("false", res.response.body)
          end

          sig {params(c: Client).returns([String, URI::HTTP])}
          def endpoint(c)
            ["GET", T.cast(URI.join(c.base_uri, "healthcheck"), URI::HTTP)]
          end
        end
      end
    end
  end
end
