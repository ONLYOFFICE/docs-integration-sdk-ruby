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

require "stringio"
require "test/unit"
require_relative "client"

module Onlyoffice
  module DocsIntegrationSdk
    module Test
      module DocumentServer
        module Client
          extend T::Sig
          include ::Test::Unit::Assertions

          sig {returns(T::Array[[String, T.class_of(Net::HTTPRequest)]])}
          def http_methods
            [
              ["DELETE", Net::HTTP::Delete],
              ["GET", Net::HTTP::Get],
              ["HEAD", Net::HTTP::Head],
              ["OPTIONS", Net::HTTP::Options],
              ["PATCH", Net::HTTP::Patch],
              ["POST", Net::HTTP::Post],
              ["PUT", Net::HTTP::Put],
              ["TRACE", Net::HTTP::Trace],
            ]
          end

          sig {params(m: String, u: URI::HTTP, req: Net::HTTPRequest).void}
          def check_request_basics(m, u, req)
            assert_equal(m, req.method)
            assert_equal(u, req.uri)
          end

          sig {params(m: String, u: URI::HTTP, req: Net::HTTPRequest).void}
          def check_request_headers(m, u, req)
            h = {
              "accept" => ["application/json"],
              "accept-encoding" => ["gzip;q=1.0,deflate;q=0.6,identity;q=0.3"],
              "host" => ["#{u.host}:#{u.port}"],
              "user-agent" => [DocsIntegrationSdk::DocumentServer::Client::USER_AGENT],
            }

            if RUBY_VERSION < "3.0.0" && m == "HEAD"
              h.delete("accept-encoding")
            end

            assert_equal(h, req.to_hash)
          end

          sig {params(m: String, u: URI::HTTP, a: String, req: Net::HTTPRequest).void}
          def check_request_headers_with_custom_user_agent(m, u, a, req)
            h = {
              "accept" => ["application/json"],
              "accept-encoding" => ["gzip;q=1.0,deflate;q=0.6,identity;q=0.3"],
              "host" => ["#{u.host}:#{u.port}"],
              "user-agent" => [a],
            }

            if RUBY_VERSION < "3.0.0" && m == "HEAD"
              h.delete("accept-encoding")
            end

            assert_equal(h, req.to_hash)
          end

          sig {params(m: String, u: URI::HTTP, req: Net::HTTPRequest).void}
          def check_request_headers_with_content_type(m, u, req)
            h = {
              "accept" => ["application/json"],
              "accept-encoding" => ["gzip;q=1.0,deflate;q=0.6,identity;q=0.3"],
              "content-type" => ["application/json"],
              "host" => ["#{u.host}:#{u.port}"],
              "user-agent" => [DocsIntegrationSdk::DocumentServer::Client::USER_AGENT],
            }

            if RUBY_VERSION < "3.0.0" && m == "HEAD"
              h.delete("accept-encoding")
            end

            assert_equal(h, req.to_hash)
          end

          sig {params(m: String, u: URI::HTTP, a: String, req: Net::HTTPRequest).void}
          def check_request_headers_with_content_type_and_custom_user_agent(m, u, a, req)
            h = {
              "accept" => ["application/json"],
              "accept-encoding" => ["gzip;q=1.0,deflate;q=0.6,identity;q=0.3"],
              "content-type" => ["application/json"],
              "host" => ["#{u.host}:#{u.port}"],
              "user-agent" => [a],
            }

            if RUBY_VERSION < "3.0.0" && m == "HEAD"
              h.delete("accept-encoding")
            end

            assert_equal(h, req.to_hash)
          end

          sig {params(m: String, u: URI::HTTP, w: JwtDecoding, b: T.untyped, req: Net::HTTPRequest).void}
          def check_request_headers_with_jwt(m, u, w, b, req)
            x = {
              "accept" => ["application/json"],
              "accept-encoding" => ["gzip;q=1.0,deflate;q=0.6,identity;q=0.3"],
              "content-type" => ["application/json"],
              "host" => ["#{u.host}:#{u.port}"],
              "user-agent" => [DocsIntegrationSdk::DocumentServer::Client::USER_AGENT],
            }

            if RUBY_VERSION < "3.0.0" && m == "HEAD"
              x.delete("accept-encoding")
            end

            y = req.to_hash

            r = y["authorization"]
            assert_equal(1, r.length)
            assert_true(r[0].start_with?("Bearer "))

            y.delete("authorization")
            assert_equal(x, y)

            t = r[0].sub("Bearer ", "")
            assert_equal(b, w.decode_header(t))
          end

          sig {params(m: String, u: URI::HTTP, w: JwtDecoding, h: String, b: T::Hash[String, T.untyped], req: Net::HTTPRequest).void}
          def check_request_headers_with_custom_jwt_header(m, u, w, h, b, req)
            x = {
              "accept" => ["application/json"],
              "accept-encoding" => ["gzip;q=1.0,deflate;q=0.6,identity;q=0.3"],
              "content-type" => ["application/json"],
              "host" => ["#{u.host}:#{u.port}"],
              "user-agent" => [DocsIntegrationSdk::DocumentServer::Client::USER_AGENT],
            }

            if RUBY_VERSION < "3.0.0" && m == "HEAD"
              x.delete("accept-encoding")
            end

            y = req.to_hash

            r = y[h.downcase]
            assert_equal(1, r.length)
            assert_true(r[0].start_with?("Bearer "))

            y.delete(h.downcase)
            assert_equal(x, y)

            t = r[0].sub("Bearer ", "")
            assert_equal(b, w.decode_header(t))
          end

          sig {params(m: String, u: URI::HTTP, w: JwtDecoding, s: String, b: T::Hash[String, T.untyped], req: Net::HTTPRequest).void}
          def check_request_headers_with_custom_jwt_schema(m, u, w, s, b, req)
            x = {
              "accept" => ["application/json"],
              "accept-encoding" => ["gzip;q=1.0,deflate;q=0.6,identity;q=0.3"],
              "content-type" => ["application/json"],
              "host" => ["#{u.host}:#{u.port}"],
              "user-agent" => [DocsIntegrationSdk::DocumentServer::Client::USER_AGENT],
            }

            if RUBY_VERSION < "3.0.0" && m == "HEAD"
              x.delete("accept-encoding")
            end

            y = req.to_hash

            r = y["authorization"]
            assert_equal(1, r.length)
            assert_true(r[0].start_with?("#{s} "))

            y.delete("authorization")
            assert_equal(x, y)

            t = r[0].sub("#{s} ", "")
            assert_equal(b, w.decode_header(t))
          end

          sig {params(w: JwtDecoding, b: T::Hash[String, T.untyped], req: Net::HTTPRequest).void}
          def check_request_body_with_jwt(w, b, req)
            h = T.let(JSON.parse(req.body), T::Hash[String, T.untyped])
            assert_equal(b, w.decode_body(h))
          end

          sig {params(b: String).returns(Net::HTTPResponse)}
          def create_ok(b)
            raw =
              "HTTP/1.1 200 OK\r\n" +
              "Content-Type: application/json; charset=utf-8\r\n" +
              "\r\n" +
              b
            sock = ::StringIO.new(raw)
            buf = Net::BufferedIO.new(sock)
            res = Net::HTTPResponse.read_new(buf)
            res.reading_body(buf, true) {}
            res
          end
        end
      end
    end

    module DocumentServer
      class ClientTest < ::Test::Unit::TestCase
        extend T::Sig
        include Test::DocumentServer::Client

        sig {returns(String)}
        def hi_s
          '{"v":"hi"}'
        end

        sig {returns(T::Hash[String, T.untyped])}
        def hi_h
          {"v" => "hi"}
        end

        sig {returns(String)}
        def bye_s
          '{"v":"bye"}'
        end

        sig {returns(T::Hash[String, T.untyped])}
        def bye_h
          {"v" => "bye"}
        end

        sig {params(m: String, u: URI::HTTP, req: Net::HTTPRequest).void}
        def check_ruby_request_headers(m, u, req)
          h = {
            "accept" => ["*/*"],
            "accept-encoding" => ["gzip;q=1.0,deflate;q=0.6,identity;q=0.3"],
            "host" => ["#{u.host}:#{u.port}"],
            "user-agent" => ["Ruby"],
          }

          if RUBY_VERSION < "3.0.0" && m == "HEAD"
            h.delete("accept-encoding")
          end

          assert_equal(h, req.to_hash)
        end

        sig {params(m: String, u: URI::HTTP, w: JwtDecoding, b: T.untyped, req: Net::HTTPRequest).void}
        def check_ruby_request_headers_with_jwt(m, u, w, b, req)
          x = {
            "accept" => ["*/*"],
            "accept-encoding" => ["gzip;q=1.0,deflate;q=0.6,identity;q=0.3"],
            "host" => ["#{u.host}:#{u.port}"],
            "user-agent" => ["Ruby"],
          }

          if RUBY_VERSION < "3.0.0" && m == "HEAD"
            x.delete("accept-encoding")
          end

          y = req.to_hash

          r = y["authorization"]
          assert_equal(1, r.length)
          assert_true(r[0].start_with?("Bearer "))

          y.delete("authorization")
          assert_equal(x, y)

          t = r[0].sub("Bearer ", "")
          assert_equal(b, w.decode_header(t))
        end

        sig {params(m: String, u: URI::HTTP, w: JwtDecoding, s: String, b: T::Hash[String, T.untyped], req: Net::HTTPRequest).void}
        def check_ruby_request_headers_with_custom_jwt_header(m, u, w, s, b, req)
          x = {
            "accept" => ["*/*"],
            "accept-encoding" => ["gzip;q=1.0,deflate;q=0.6,identity;q=0.3"],
            "host" => ["#{u.host}:#{u.port}"],
            "user-agent" => ["Ruby"],
          }

          if RUBY_VERSION < "3.0.0" && m == "HEAD"
            x.delete("accept-encoding")
          end

          y = req.to_hash

          r = y[s.downcase]
          assert_equal(1, r.length)
          assert_true(r[0].start_with?("Bearer "))

          y.delete(s.downcase)
          assert_equal(x, y)

          t = r[0].sub("Bearer ", "")
          assert_equal(b, w.decode_header(t))
        end

        sig {params(m: String, u: URI::HTTP, w: JwtDecoding, s: String, b: T::Hash[String, T.untyped], req: Net::HTTPRequest).void}
        def check_ruby_request_headers_with_custom_jwt_schema(m, u, w, s, b, req)
          x = {
            "accept" => ["*/*"],
            "accept-encoding" => ["gzip;q=1.0,deflate;q=0.6,identity;q=0.3"],
            "host" => ["#{u.host}:#{u.port}"],
            "user-agent" => ["Ruby"],
          }

          if RUBY_VERSION < "3.0.0" && m == "HEAD"
            x.delete("accept-encoding")
          end

          y = req.to_hash

          r = y["authorization"]
          assert_equal(1, r.length)
          assert_true(r[0].start_with?("#{s} "))

          y.delete("authorization")
          assert_equal(x, y)

          t = r[0].sub("#{s} ", "")
          assert_equal(b, w.decode_header(t))
        end

        sig {params(w: JwtDecoding, b: T::Hash[String, T.untyped], body: T.untyped).void}
        def check_body_with_jwt(w, b, body)
          h = T.let(JSON.parse(body), T::Hash[String, T.untyped])
          assert_equal(b, w.decode_body(h))
        end

        def test_initialize_initializes_with_a_http_and_a_base_uri
          u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
          h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)
          c = Client.new(base_uri: u, http: h)

          assert_not_equal(h.object_id, c.http.object_id)
          assert_equal(h.address, c.http.address)
          assert_equal(h.port, c.http.port)

          assert_not_equal(u.object_id, c.base_uri.object_id)
          assert_equal(u, c.base_uri)

          assert_equal(Client::USER_AGENT, c.user_agent)

          assert_kind_of(Client::CommandService, c.command)
          assert_kind_of(Client::ConversionService, c.conversion)
          assert_kind_of(Client::HealthcheckService, c.healthcheck)
        end

        def test_initialize_initializes_with_a_http
          u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
          h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)
          c = Client.new(http: h)

          assert_not_equal(h.object_id, c.http.object_id)
          assert_equal(h.address, c.http.address)
          assert_equal(h.port, c.http.port)

          assert_not_equal(u.object_id, c.base_uri.object_id)
          assert_equal(u, c.base_uri)

          assert_equal(Client::USER_AGENT, c.user_agent)

          assert_kind_of(Client::CommandService, c.command)
          assert_kind_of(Client::ConversionService, c.conversion)
          assert_kind_of(Client::HealthcheckService, c.healthcheck)
        end

        def test_initialize_initializes_with_a_base_uri
          u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
          c = Client.new(base_uri: u)

          assert_equal(u.hostname, c.http.address)
          assert_equal(u.port, c.http.port)

          assert_not_equal(u.object_id, c.base_uri.object_id)
          assert_equal(u, c.base_uri)

          assert_equal(Client::USER_AGENT, c.user_agent)

          assert_kind_of(Client::CommandService, c.command)
          assert_kind_of(Client::ConversionService, c.conversion)
          assert_kind_of(Client::HealthcheckService, c.healthcheck)
        end

        def test_initialize_initializes_with_a_user_agent
          u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
          c = Client.new(base_uri: u, user_agent: "my-agent")

          assert_equal(u.hostname, c.http.address)
          assert_equal(u.port, c.http.port)

          assert_not_equal(u.object_id, c.base_uri.object_id)
          assert_equal(u, c.base_uri)

          assert_equal("my-agent", c.user_agent)

          assert_kind_of(Client::CommandService, c.command)
          assert_kind_of(Client::ConversionService, c.conversion)
          assert_kind_of(Client::HealthcheckService, c.healthcheck)
        end

        def test_initialize_raises_an_error_if_neither_a_base_uri_nor_a_http_are_provided
          assert_raise_with_message(ArgumentError, "Either http or base_uri must be provided") do
            Client.new
          end
        end

        def test_with_jwt_creates_a_copy_of_the_client_with_a_jwt
          w = Jwt.new(secret: "***")
          j = Client::Jwt.new(jwt: w)
          u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
          h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)
          o = Client.new(base_uri: u, http: h)

          n = o.with_jwt(j)
          assert_not_equal(o.object_id, n.object_id)
        end

        def test_with_jwt_preserves_the_request_stack
          for m, n in http_methods
            t = self

            w = Jwt.new(secret: "***")
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            f = T.let(0, Integer)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              f += 1
              block.call
              t.create_ok("{}")
            end

            r = h.method(:request)
            h = h.clone

            h.define_singleton_method(:request) do |req, body = nil, &block|
              f += 1
              r.call(req, body, &block)
            end

            j = Client::Jwt.new(jwt: w)
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            res = c.http.request(n.new(u)) do
              f += 1
            end

            assert_kind_of(Net::HTTPOK, res)

            assert_equal(3, f)
            assert_equal("{}", res.body)
          end
        end

        def test_with_jwt_passes_through_itself_when_both_the_request_body_and_the_argument_body_are_present
          for m, n in http_methods
            w = Jwt.new(secret: "***")
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:start) do
              # Mock the start method to prevent the connection from being
              # established.
            end

            j = Client::Jwt.new(jwt: w)
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            r = n.new(u)
            r.body = "{}"

            assert_raise_with_message(ArgumentError, "both of body argument and HTTPRequest#body set") do
              c.http.request(r, "{}")
            end
          end
        end

        def test_with_jwt_passes_through_itself_when_both_the_request_body_stream_and_the_argument_body_are_present
          for m, n in http_methods
            w = Jwt.new(secret: "***")
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:start) do
              # Mock the start method to prevent the connection from being
              # established.
            end

            j = Client::Jwt.new(jwt: w)
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            r = n.new(u)
            r.body_stream = StringIO.new("{}")

            assert_raise_with_message(ArgumentError, "both of body argument and HTTPRequest#body set") do
              c.http.request(r, "{}")
            end
          end
        end

        def test_with_jwt_injects_the_jwt_into_the_header_when_the_request_body_is_present
          for m, n in http_methods
            t = self

            w = Jwt.new(secret: "***")
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, u, req)
              t.check_ruby_request_headers_with_jwt(m, u, w, t.hi_h, req)
              t.assert_equal(t.hi_s, req.body)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok(t.bye_s)
            end

            j = Client::Jwt.new(jwt: w, locations: [Client::Jwt::Location::Header])
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            req = n.new(u)
            req.body = t.hi_s

            res = c.http.request(req)
            assert_equal(t.bye_s, res.body)
          end
        end

        def test_with_jwt_injects_the_jwt_into_the_body_when_the_request_body_is_present
          for m, n in http_methods
            t = self

            w = Jwt.new(secret: "***")
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, u, req)
              t.check_ruby_request_headers(m, u, req)
              t.check_request_body_with_jwt(w, t.hi_h, req)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok(t.bye_s)
            end

            j = Client::Jwt.new(jwt: w, locations: [Client::Jwt::Location::Body])
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            req = n.new(u)
            req.body = t.hi_s

            res = c.http.request(req)
            assert_equal(t.bye_s, res.body)
          end
        end

        def test_with_jwt_injects_the_jwt_into_multiple_locations_when_the_request_body_is_present
          for m, n in http_methods
            t = self

            w = Jwt.new(secret: "***")
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, u, req)
              t.check_ruby_request_headers_with_jwt(m, u, w, t.hi_h, req)
              t.check_request_body_with_jwt(w, t.hi_h, req)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok(t.bye_s)
            end

            j = Client::Jwt.new(
              jwt: w,
              locations: [
                Client::Jwt::Location::Header,
                Client::Jwt::Location::Body,
              ],
            )
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            req = n.new(u)
            req.body = t.hi_s

            res = c.http.request(req)
            assert_equal(t.bye_s, res.body)
          end
        end

        def test_with_jwt_does_not_inject_the_jwt_without_a_location_when_the_request_body_is_present
          for m, n in http_methods
            t = self

            w = Jwt.new(secret: "***")
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, u, req)
              t.check_ruby_request_headers(m, u, req)
              t.assert_equal(t.hi_s, req.body)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok(t.bye_s)
            end

            j = Client::Jwt.new(jwt: w, locations: [])
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            req = n.new(u)
            req.body = t.hi_s

            res = c.http.request(req)
            assert_equal(t.bye_s, res.body)
          end
        end

        def test_with_jwt_injects_the_jwt_with_custom_header_when_the_request_body_is_present
          for m, n in http_methods
            t = self

            w = Jwt.new(secret: "***")
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, u, req)
              t.check_ruby_request_headers_with_custom_jwt_header(m, u, w, "X-Auth", t.hi_h, req)
              t.check_request_body_with_jwt(w, t.hi_h, req)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok(t.bye_s)
            end

            j = Client::Jwt.new(jwt: w, header: "X-Auth")
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            req = n.new(u)
            req.body = t.hi_s

            res = c.http.request(req)
            assert_equal(t.bye_s, res.body)
          end
        end

        def test_with_jwt_injects_the_jwt_with_custom_schema_when_the_request_body_is_present
          for m, n in http_methods
            t = self

            w = Jwt.new(secret: "***")
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, u, req)
              t.check_ruby_request_headers_with_custom_jwt_schema(m, u, w, "Token", t.hi_h, req)
              t.check_request_body_with_jwt(w, t.hi_h, req)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok(t.bye_s)
            end

            j = Client::Jwt.new(jwt: w, schema: "Token")
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            req = n.new(u)
            req.body = t.hi_s

            res = c.http.request(req)
            assert_equal(t.bye_s, res.body)
          end
        end

        def test_with_jwt_does_not_inject_the_jwt_when_the_request_body_stream_is_present
          for m, n in http_methods
            t = self

            w = Jwt.new(secret: "***")
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, u, req)
              t.check_ruby_request_headers(m, u, req)
              t.assert_nil(req.body)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok(t.bye_s)
            end

            j = Client::Jwt.new(jwt: w)
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            req = n.new(u)
            req.body_stream = StringIO.new(t.hi_s)

            res = c.http.request(req)
            assert_equal(t.bye_s, res.body)
          end
        end

        def test_with_jwt_injects_the_jwt_into_the_header_when_the_argument_body_is_present
          for m, n in http_methods
            t = self

            w = Jwt.new(secret: "***")
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, u, req)
              t.check_ruby_request_headers_with_jwt(m, u, w, t.hi_h, req)
              t.assert_nil(req.body)
              t.assert_equal(t.hi_s, body)
              t.assert_nil(block)
              t.create_ok(t.bye_s)
            end

            j = Client::Jwt.new(jwt: w, locations: [Client::Jwt::Location::Header])
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            res = c.http.request(n.new(u), t.hi_s)
            assert_equal(t.bye_s, res.body)
          end
        end

        def test_with_jwt_injects_the_jwt_into_the_body_when_the_argument_body_is_present
          for m, n in http_methods
            t = self

            w = Jwt.new(secret: "***")
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, u, req)
              t.check_ruby_request_headers(m, u, req)
              t.assert_nil(req.body)
              t.check_body_with_jwt(w, t.hi_h, body)
              t.assert_nil(block)
              t.create_ok(t.bye_s)
            end

            j = Client::Jwt.new(jwt: w, locations: [Client::Jwt::Location::Body])
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            res = c.http.request(n.new(u), t.hi_s)
            assert_equal(t.bye_s, res.body)
          end
        end

        def test_with_jwt_injects_the_jwt_into_multiple_locations_when_the_argument_body_is_present
          for m, n in http_methods
            t = self

            w = Jwt.new(secret: "***")
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, u, req)
              t.check_ruby_request_headers_with_jwt(m, u, w, t.hi_h, req)
              t.assert_nil(req.body)
              t.check_body_with_jwt(w, t.hi_h, body)
              t.assert_nil(block)
              t.create_ok(t.bye_s)
            end

            j = Client::Jwt.new(
              jwt: w,
              locations: [
                Client::Jwt::Location::Header,
                Client::Jwt::Location::Body,
              ],
            )
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            res = c.http.request(n.new(u), t.hi_s)
            assert_equal(t.bye_s, res.body)
          end
        end

        def test_with_jwt_does_not_inject_the_jwt_without_a_location_when_the_argument_body_is_present
          for m, n in http_methods
            t = self

            w = Jwt.new(secret: "***")
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, u, req)
              t.check_ruby_request_headers(m, u, req)
              t.assert_nil(req.body)
              t.assert_equal(t.hi_s, body)
              t.assert_nil(block)
              t.create_ok(t.bye_s)
            end

            j = Client::Jwt.new(jwt: w, locations: [])
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            res = c.http.request(n.new(u), t.hi_s)
            assert_equal(t.bye_s, res.body)
          end
        end

        def test_with_jwt_injects_the_jwt_with_custom_header_when_the_argument_body_is_present
          for m, n in http_methods
            t = self

            w = Jwt.new(secret: "***")
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, u, req)
              t.check_ruby_request_headers_with_custom_jwt_header(m, u, w, "X-Auth", t.hi_h, req)
              t.assert_nil(req.body)
              t.check_body_with_jwt(w, t.hi_h, body)
              t.assert_nil(block)
              t.create_ok(t.bye_s)
            end

            j = Client::Jwt.new(jwt: w, header: "X-Auth")
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            res = c.http.request(n.new(u), t.hi_s)
            assert_equal(t.bye_s, res.body)
          end
        end

        def test_with_jwt_injects_the_jwt_with_custom_schema_when_the_argument_body_is_present
          for m, n in http_methods
            t = self

            w = Jwt.new(secret: "***")
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, u, req)
              t.check_ruby_request_headers_with_custom_jwt_schema(m, u, w, "Token", t.hi_h, req)
              t.assert_nil(req.body)
              t.check_body_with_jwt(w, t.hi_h, body)
              t.assert_nil(block)
              t.create_ok(t.bye_s)
            end

            j = Client::Jwt.new(jwt: w, schema: "Token")
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            res = c.http.request(n.new(u), t.hi_s)
            assert_equal(t.bye_s, res.body)
          end
        end

        def test_uri_creates_a_uri
          cases = [
            ["http://localhost:8080", "", "http://localhost:8080"],
            ["http://localhost:8080", "/", "http://localhost:8080/"],
            ["http://localhost:8080", "b", "http://localhost:8080/b"],
            ["http://localhost:8080", "/b", "http://localhost:8080/b"],
            ["http://localhost:8080", "b/", "http://localhost:8080/b/"],
            ["http://localhost:8080", "/b/", "http://localhost:8080/b/"],

            ["http://localhost:8080/", "", "http://localhost:8080/"],
            ["http://localhost:8080/", "/", "http://localhost:8080/"],
            ["http://localhost:8080/", "b", "http://localhost:8080/b"],
            ["http://localhost:8080/", "/b", "http://localhost:8080/b"],
            ["http://localhost:8080/", "b/", "http://localhost:8080/b/"],
            ["http://localhost:8080/", "/b/", "http://localhost:8080/b/"],

            ["http://localhost:8080/a", "", "http://localhost:8080/a"],
            ["http://localhost:8080/a", "/", "http://localhost:8080/"],
            ["http://localhost:8080/a", "b", "http://localhost:8080/b"],
            ["http://localhost:8080/a", "/b", "http://localhost:8080/b"],
            ["http://localhost:8080/a", "b/", "http://localhost:8080/b/"],
            ["http://localhost:8080/a", "/b/", "http://localhost:8080/b/"],

            ["http://localhost:8080/a/", "", "http://localhost:8080/a/"],
            ["http://localhost:8080/a/", "/", "http://localhost:8080/"],
            ["http://localhost:8080/a/", "b", "http://localhost:8080/a/b"],
            ["http://localhost:8080/a/", "/b", "http://localhost:8080/b"],
            ["http://localhost:8080/a/", "b/", "http://localhost:8080/a/b/"],
            ["http://localhost:8080/a/", "/b/", "http://localhost:8080/b/"],
          ]

          for f, p, t in cases
            u = T.cast(URI.parse(f), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)
            c = Client.new(base_uri: u, http: h)

            u = c.uri(p)
            assert_equal(t, u.to_s)
          end
        end

        def test_request_creates_a_request
          for m, n in http_methods
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)
            c = Client.new(base_uri: u, http: h)

            r = c.request(n, u)
            check_request_basics(m, u, r)
            check_request_headers(m, u, r)
            assert_nil(r.body)
          end
        end

        def test_request_creates_a_request_with_a_user_agent
          for m, n in http_methods
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)
            c = Client.new(base_uri: u, http: h, user_agent: "my-agent")

            r = c.request(n, u)
            check_request_basics(m, u, r)
            check_request_headers_with_custom_user_agent(m, u, "my-agent", r)
            assert_nil(r.body)
          end
        end

        def test_request_creates_a_request_with_a_body
          for m, n in http_methods
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)
            c = Client.new(base_uri: u, http: h)

            r = c.request(n, u, hi_h)
            check_request_basics(m, u, r)
            check_request_headers_with_content_type(m, u, r)
            assert_equal(hi_s, r.body)
          end
        end

        def test_do_does_the_request
          for m, n in http_methods
            t = self

            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, u, req)
              t.check_request_headers(m, u, req)
              t.assert_nil(req.body)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok(t.bye_s)
            end

            c = Client.new(base_uri: u, http: h)

            req = c.request(n, u)
            b, res = c.do(req)
            assert_nil(res.error)

            assert_equal(req, res.request)
            assert_equal(bye_s, res.response.body)
            assert_equal(bye_h, b)
          end
        end

        def test_do_does_the_request_with_the_user_agent
          for m, n in http_methods
            t = self

            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, u, req)
              t.check_request_headers_with_custom_user_agent(m, u, "my-agent", req)
              t.assert_nil(req.body)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok(t.bye_s)
            end

            c = Client.new(base_uri: u, http: h, user_agent: "my-agent")

            req = c.request(n, u)
            b, res = c.do(req)
            assert_nil(res.error)

            assert_equal(req, res.request)
            assert_equal(bye_s, res.response.body)
            assert_equal(bye_h, b)
          end
        end

        def test_do_does_the_request_with_the_body
          for m, n in http_methods
            t = self

            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, u, req)
              t.check_request_headers_with_content_type(m, u, req)
              t.assert_equal(t.hi_s, req.body)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok(t.bye_s)
            end

            c = Client.new(base_uri: u, http: h)

            req = c.request(n, u, hi_h)
            b, res = c.do(req)
            assert_nil(res.error)

            assert_equal(req, res.request)
            assert_equal(bye_s, res.response.body)
            assert_equal(bye_h, b)
          end
        end

        def test_do_returns_an_error_if_the_response_body_is_invalid_json
          for m, n in http_methods
            t = self

            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, u, req)
              t.check_request_headers(m, u, req)
              t.assert_nil(req.body)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok("}")
            end

            c = Client.new(base_uri: u, http: h)

            req = c.request(n, u)
            b, res = c.do(req)

            err = T.cast(res.error, JSON::ParserError)
            assert_equal("unexpected token at '}'", err.message)

            assert_equal(req, res.request)
            assert_equal("}", res.response.body)
            assert_nil(b)
          end
        end

        def test_do_does_the_request_with_the_jwt_in_the_header_location
          for m, n in http_methods
            t = self

            w = Jwt.new(secret: "***")
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, u, req)
              t.check_request_headers_with_jwt(m, u, w, t.hi_h, req)
              t.assert_equal(t.hi_s, req.body)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok(t.bye_s)
            end

            j = Client::Jwt.new(jwt: w, locations: [Client::Jwt::Location::Header])
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            req = c.request(n, u, hi_h)
            b, res = c.do(req)
            assert_nil(res.error)

            assert_equal(req, res.request)
            assert_equal(bye_s, res.response.body)
            assert_equal(bye_h, b)
          end
        end

        def test_do_does_the_request_with_the_jwt_in_the_body_location
          for m, n in http_methods
            t = self

            w = Jwt.new(secret: "***")
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, u, req)
              t.check_request_headers_with_content_type(m, u, req)
              t.check_request_body_with_jwt(w, t.hi_h, req)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok(t.bye_s)
            end

            j = Client::Jwt.new(jwt: w, locations: [Client::Jwt::Location::Body])
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            req = c.request(n, u, hi_h)
            b, res = c.do(req)
            assert_nil(res.error)

            assert_equal(req, res.request)
            assert_equal(bye_s, res.response.body)
            assert_equal(bye_h, b)
          end
        end

        def test_do_does_the_request_with_the_jwt_in_multiple_locations
          for m, n in http_methods
            t = self

            w = Jwt.new(secret: "***")
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, u, req)
              t.check_request_headers_with_jwt(m, u, w, t.hi_h, req)
              t.check_request_body_with_jwt(w, t.hi_h, req)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok(t.bye_s)
            end

            j = Client::Jwt.new(
              jwt: w,
              locations: [
                Client::Jwt::Location::Header,
                Client::Jwt::Location::Body,
              ],
            )
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            req = c.request(n, u, hi_h)
            b, res = c.do(req)
            assert_nil(res.error)

            assert_equal(req, res.request)
            assert_equal(bye_s, res.response.body)
            assert_equal(bye_h, b)
          end
        end

        def test_do_does_the_request_without_the_jwt_when_no_location_is_specified
          for m, n in http_methods
            t = self

            w = Jwt.new(secret: "***")
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, u, req)
              t.check_request_headers_with_content_type(m, u, req)
              t.assert_equal(t.hi_s, req.body)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok(t.bye_s)
            end

            j = Client::Jwt.new(jwt: w, locations: [])
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            req = c.request(n, u, hi_h)
            b, res = c.do(req)
            assert_nil(res.error)

            assert_equal(req, res.request)
            assert_equal(bye_s, res.response.body)
            assert_equal(bye_h, b)
          end
        end

        def test_do_does_the_request_with_custom_jwt_header
          for m, n in http_methods
            t = self
            w = Jwt.new(secret: "***")
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, u, req)
              t.check_request_headers_with_custom_jwt_header(m, u, w, "X-Auth", t.hi_h, req)
              t.check_request_body_with_jwt(w, t.hi_h, req)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok(t.bye_s)
            end

            j = Client::Jwt.new(jwt: w, header: "X-Auth")
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            req = c.request(n, u, t.hi_h)
            b, res = c.do(req)
            assert_nil(res.error)

            assert_equal(req, res.request)
            assert_equal(bye_s, res.response.body)
            assert_equal(bye_h, b)
          end
        end

        def test_do_does_the_request_with_custom_jwt_schema
          for m, n in http_methods
            t = self

            w = Jwt.new(secret: "***")
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

            h.define_singleton_method(:request) do |req, body = nil, &block|
              t.check_request_basics(m, u, req)
              t.check_request_headers_with_custom_jwt_schema(m, u, w, "Token", t.hi_h, req)
              t.check_request_body_with_jwt(w, t.hi_h, req)
              t.assert_nil(body)
              t.assert_nil(block)
              t.create_ok(t.bye_s)
            end

            j = Client::Jwt.new(jwt: w, schema: "Token")
            c = Client.new(base_uri: u, http: h).with_jwt(j)

            req = c.request(n, u, t.hi_h)
            b, res = c.do(req)
            assert_nil(res.error)

            assert_equal(req, res.request)
            assert_equal(bye_s, res.response.body)
            assert_equal(bye_h, b)
          end
        end
      end
    end
  end
end
