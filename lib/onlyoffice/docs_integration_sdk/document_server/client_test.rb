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

require_relative "client"

module Onlyoffice
  module DocsIntegrationSdk
    module DocumentServer
      class ClientTest < Test::Unit::TestCase
        extend T::Sig

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
          m = "GET"
          n = Net::HTTP::Get

          w = Jwt.new(secret: "***")
          j = Client::Jwt.new(jwt: w)
          u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
          h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)

          f = T.let(false, T::Boolean)
          r = h.method(:request)
          h = h.clone

          h.define_singleton_method(:request) do |req, body = nil, &block|
            f = true
            r.call(req, body, &block)
          end

          c = Client.new(base_uri: u, http: h).with_jwt(j)

          WebMock.stub_request(m.downcase.to_sym, u)

          res = c.http.request(n.new(u))
          assert_kind_of(Net::HTTPOK, res)

          assert_true(f)
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
          for m, n in methods
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)
            c = Client.new(base_uri: u, http: h)
            f = headers(c)

            r = c.request(n, u)
            assert_equal(m, r.method)
            assert_equal(u, r.uri)
            assert_equal(f, r.to_hash)
            assert_nil(r.body)
          end
        end

        def test_request_creates_a_request_with_a_user_agent
          for m, n in methods
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)
            c = Client.new(base_uri: u, http: h, user_agent: "my-agent")
            f = headers(c)

            r = c.request(n, u)
            assert_equal(m, r.method)
            assert_equal(u, r.uri)
            assert_equal(f, r.to_hash)
            assert_nil(r.body)
          end
        end

        def test_request_creates_a_request_with_a_body
          for m, n in methods
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)
            c = Client.new(base_uri: u, http: h)
            f = headers_with_content_type(c)

            r = c.request(n, u, {"value" => "hi"})
            assert_equal(m, r.method)
            assert_equal(u, r.uri)
            assert_equal(f, r.to_hash)
            assert_equal('{"value":"hi"}', r.body)
          end
        end

        def test_do_does_a_request
          for m, n in methods
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)
            c = Client.new(base_uri: u, http: h)
            f = headers(c)

            WebMock.stub_request(m.downcase.to_sym, u).
              with(headers: f).
              to_return(body: '{"value":"hi"}')

            req = c.request(n, u)
            b, res = c.do(req)
            assert_nil(res.error)

            assert_equal(req, res.request)
            assert_equal(m, res.request.method)
            assert_equal(u, res.request.uri)
            assert_equal(f, res.request.to_hash)
            assert_true(res.request.body == nil || res.request.body == "")

            assert_equal('{"value":"hi"}', res.response.body)
            assert_equal({"value" => "hi"}, b)
          end
        end

        def test_do_does_a_request_with_a_user_agent
          for m, n in methods
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)
            c = Client.new(base_uri: u, http: h, user_agent: "my-agent")
            f = headers(c)

            WebMock.stub_request(m.downcase.to_sym, u).
              with(headers: f).
              to_return(body: '{"value":"hi"}')

            req = c.request(n, u)
            b, res = c.do(req)
            assert_nil(res.error)

            assert_equal(req, res.request)
            assert_equal(m, res.request.method)
            assert_equal(u, res.request.uri)
            assert_equal(f, res.request.to_hash)
            assert_true(res.request.body == nil || res.request.body == "")

            assert_equal('{"value":"hi"}', res.response.body)
            assert_equal({"value" => "hi"}, b)
          end
        end

        def test_do_does_a_request_with_a_body
          for m, n in methods
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)
            c = Client.new(base_uri: u, http: h)
            f = headers_with_content_type(c)

            WebMock.stub_request(m.downcase.to_sym, u).
              with(headers: f).
              to_return(body: '{"value":"hello"}')

            req = c.request(n, u, {"value" => "hi"})
            b, res = c.do(req)
            assert_nil(res.error)

            assert_equal(req, res.request)
            assert_equal(m, res.request.method)
            assert_equal(u, res.request.uri)
            assert_equal(f, res.request.to_hash)
            assert_equal('{"value":"hi"}', res.request.body)

            assert_equal('{"value":"hello"}', res.response.body)
            assert_equal({"value" => "hello"}, b)
          end
        end

        def test_do_returns_an_error_if_the_response_body_is_invalid_json
          for m, n in methods
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)
            c = Client.new(base_uri: u, http: h)
            f = headers(c)

            WebMock.stub_request(m.downcase.to_sym, u).
              with(headers: f).
              to_return(body: '}')

            req = c.request(n, u)
            b, res = c.do(req)

            err = T.cast(res.error, JSON::ParserError)
            assert_equal("unexpected token at '}'", err.message)

            assert_equal(req, res.request)
            assert_equal(m, res.request.method)
            assert_equal(u, res.request.uri)
            assert_equal(f, res.request.to_hash)
            assert_true(res.request.body == nil || res.request.body == "")

            assert_equal(req, res.request)
            assert_equal("}", res.response.body)
            assert_nil(b)
          end
        end

        def test_do_does_a_request_with_a_jwt_in_the_header_location
          for m, n in methods
            w = Jwt.new(secret: "***")
            j = Client::Jwt.new(jwt: w, locations: [Client::Jwt::Location::Header])
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)
            c = Client.new(base_uri: u, http: h).with_jwt(j)
            f0 = headers_with_content_type(c)

            WebMock.stub_request(m.downcase.to_sym, u).
              with(headers: f0).
              to_return(body: '{"value":"hello"}')

            p0 = {"value" => "hi"}
            req = c.request(n, u, p0)
            b, res = c.do(req)
            assert_nil(res.error)

            assert_equal(req, res.request)
            assert_equal(m, res.request.method)
            assert_equal(u, res.request.uri)
            assert_equal('{"value":"hi"}', res.request.body)

            f1 = T.let(res.request.to_hash, T::Hash[String, T::Array[String]])

            aa = T.cast(f1[j.header.downcase], T::Array[String])
            as = T.cast(aa[0], String)
            assert_equal(1, aa.length)
            assert_true(as.start_with?("#{j.schema} "))

            f1.delete(j.header.downcase)
            assert_equal(f0, f1)

            t = as.sub("#{j.schema} ", "")
            p1 = w.decode_header(t)
            assert_equal(p0, p1)

            assert_equal('{"value":"hello"}', res.response.body)
            assert_equal({"value" => "hello"}, b)
          end
        end

        def test_do_does_a_request_with_a_jwt_in_the_body_location
          for m, n in methods
            w = Jwt.new(secret: "***")
            j = Client::Jwt.new(jwt: w, locations: [Client::Jwt::Location::Body])
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)
            c = Client.new(base_uri: u, http: h).with_jwt(j)
            f = headers_with_content_type(c)

            WebMock.stub_request(m.downcase.to_sym, u).
              with(headers: f).
              to_return(body: '{"value":"hello"}')

            p0 = {"value" => "hi"}
            req = c.request(n, u, p0)
            b, res = c.do(req)
            assert_nil(res.error)

            assert_equal(req, res.request)
            assert_equal(m, res.request.method)
            assert_equal(u, res.request.uri)
            assert_equal(f, res.request.to_hash)

            o = T.let(JSON.parse(res.request.body), T::Hash[String, T.untyped])
            p1 = w.decode_body(o)
            assert_equal(p0, p1)

            assert_equal('{"value":"hello"}', res.response.body)
            assert_equal({"value" => "hello"}, b)
          end
        end

        def test_do_does_a_request_with_a_jwt_in_multiple_locations
          for m, n in methods
            w = Jwt.new(secret: "***")
            j = Client::Jwt.new(
              jwt: w,
              locations: [
                Client::Jwt::Location::Header,
                Client::Jwt::Location::Body,
              ],
            )
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)
            c = Client.new(base_uri: u, http: h).with_jwt(j)
            f0 = headers_with_content_type(c)

            WebMock.stub_request(m.downcase.to_sym, u).
              with(headers: f0).
              to_return(body: '{"value":"hello"}')

            p0 = {"value" => "hi"}
            req = c.request(n, u, p0)
            b, res = c.do(req)
            assert_nil(res.error)

            assert_equal(req, res.request)
            assert_equal(m, res.request.method)
            assert_equal(u, res.request.uri)

            f1 = T.let(res.request.to_hash, T::Hash[String, T::Array[String]])

            aa = T.cast(f1[j.header.downcase], T::Array[String])
            as = T.cast(aa[0], String)
            assert_equal(1, aa.length)
            assert_true(as.start_with?("#{j.schema} "))

            f1.delete(j.header.downcase)
            assert_equal(f0, f1)

            t = as.sub("#{j.schema} ", "")
            p1 = w.decode_header(t)
            assert_equal(p0, p1)

            o = T.let(JSON.parse(res.request.body), T::Hash[String, T.untyped])
            p1 = w.decode_body(o)
            assert_equal(p0, p1)

            assert_equal('{"value":"hello"}', res.response.body)
            assert_equal({"value" => "hello"}, b)
          end
        end

        def test_do_does_a_request_with_a_jwt_in_the_header_location_and_a_custom_header
          for m, n in methods
            w = Jwt.new(secret: "***")
            j = Client::Jwt.new(
              jwt: w,
              locations: [Client::Jwt::Location::Header],
              header: "X-Auth",
            )
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)
            c = Client.new(base_uri: u, http: h).with_jwt(j)
            f0 = headers_with_content_type(c)

            WebMock.stub_request(m.downcase.to_sym, u).
              with(headers: f0).
              to_return(body: '{"value":"hello"}')

            p0 = {"value" => "hi"}
            req = c.request(n, u, p0)
            b, res = c.do(req)
            assert_nil(res.error)

            assert_equal(req, res.request)
            assert_equal(m, res.request.method)
            assert_equal(u, res.request.uri)
            assert_equal('{"value":"hi"}', res.request.body)

            f1 = T.let(res.request.to_hash, T::Hash[String, T::Array[String]])

            aa = T.cast(f1[j.header.downcase], T::Array[String])
            as = T.cast(aa[0], String)
            assert_equal(1, aa.length)
            assert_true(as.start_with?("#{j.schema} "))

            f1.delete(j.header.downcase)
            assert_equal(f0, f1)

            t = as.sub("#{j.schema} ", "")
            p1 = w.decode_header(t)
            assert_equal(p0, p1)

            assert_equal('{"value":"hello"}', res.response.body)
            assert_equal({"value" => "hello"}, b)
          end
        end

        def test_do_does_a_request_with_a_jwt_in_the_header_location_and_a_custom_schema
          for m, n in methods
            w = Jwt.new(secret: "***")
            j = Client::Jwt.new(
              jwt: w,
              locations: [Client::Jwt::Location::Header],
              schema: "Token",
            )
            u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
            h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)
            c = Client.new(base_uri: u, http: h).with_jwt(j)
            f0 = headers_with_content_type(c)

            WebMock.stub_request(m.downcase.to_sym, u).
              with(headers: f0).
              to_return(body: '{"value":"hello"}')

            p0 = {"value" => "hi"}
            req = c.request(n, u, p0)
            b, res = c.do(req)
            assert_nil(res.error)

            assert_equal(req, res.request)
            assert_equal(m, res.request.method)
            assert_equal(u, res.request.uri)
            assert_equal('{"value":"hi"}', res.request.body)

            f1 = T.let(res.request.to_hash, T::Hash[String, T::Array[String]])

            aa = T.cast(f1[j.header.downcase], T::Array[String])
            as = T.cast(aa[0], String)
            assert_equal(1, aa.length)
            assert_true(as.start_with?("#{j.schema} "))

            f1.delete(j.header.downcase)
            assert_equal(f0, f1)

            t = as.sub("#{j.schema} ", "")
            p1 = w.decode_header(t)
            assert_equal(p0, p1)

            assert_equal('{"value":"hello"}', res.response.body)
            assert_equal({"value" => "hello"}, b)
          end
        end

        sig {returns(Client)}
        def self.client
          u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
          h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)
          Client.new(base_uri: u, http: h)
        end

        sig {returns(Client)}
        def client
          self.class.client
        end

        sig {returns(Client)}
        def self.client_with_a_subpath
          u = T.cast(URI.parse("http://localhost:8080/sub/"), URI::HTTP)
          h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)
          Client.new(base_uri: u, http: h)
        end

        sig {returns(Client)}
        def client_with_a_subpath
          self.class.client_with_a_subpath
        end

        sig {returns(Client)}
        def self.client_with_a_user_agent
          u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
          h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)
          Client.new(base_uri: u, http: h, user_agent: "my-agent")
        end

        sig {returns(Client)}
        def client_with_a_user_agent
          self.class.client_with_a_user_agent
        end

        sig {returns(Client)}
        def self.client_with_a_jwt
          w = Jwt.new(secret: "***")
          j = Client::Jwt.new(jwt: w)
          u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
          h = T.let(Net::HTTP.new(u.hostname, u.port), Net::HTTP)
          Client.new(base_uri: u, http: h).with_jwt(j)
        end

        sig {returns(Client)}
        def client_with_a_jwt
          self.class.client_with_a_jwt
        end

        sig {params(c: Client).returns(T::Hash[String, T::Array[String]])}
        def self.headers(c)
          {
            "accept" => ["application/json"],
            "accept-encoding" => ["gzip;q=1.0,deflate;q=0.6,identity;q=0.3"],
            "host" => ["#{c.base_uri.host}:#{c.base_uri.port}"],
            "user-agent" => [c.user_agent],
          }
        end

        sig {params(c: Client).returns(T::Hash[String, T::Array[String]])}
        def headers(c)
          self.class.headers(c)
        end

        sig {params(c: Client).returns(T::Hash[String, T::Array[String]])}
        def self.headers_with_content_type(c)
          {
            "accept" => ["application/json"],
            "accept-encoding" => ["gzip;q=1.0,deflate;q=0.6,identity;q=0.3"],
            "content-type" => ["application/json"],
            "host" => ["#{c.base_uri.host}:#{c.base_uri.port}"],
            "user-agent" => [c.user_agent],
          }
        end

        sig {params(c: Client).returns(T::Hash[String, T::Array[String]])}
        def headers_with_content_type(c)
          self.class.headers_with_content_type(c)
        end

        sig {returns(T::Array[[String, T.class_of(Net::HTTPRequest)]])}
        def methods
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
      end
    end
  end
end
