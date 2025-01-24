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

require_relative "jwt"

module Onlyoffice
  module DocsIntegrationSdk
    class JwtTest < Test::Unit::TestCase
      extend T::Sig

      def test_initialize_initializes_with_default_values
        j = Jwt.new(secret: "***")
        assert_equal("***", j.secret)
        assert_equal("HS256", j.algorithm)
        assert_equal(2, j.claims.length)

        e = T.cast(j.claims[0], Jwt::ExpClaim)
        assert_equal(300, e.ttl)
        assert_equal(30, e.leeway)

        _ = T.cast(j.claims[1], Jwt::IatClaim)
      end

      def test_initialize_initializes_with_custom_values
        j = Jwt.new(
          secret: "***",
          algorithm: "HS512",
          claims: [Jwt::ExpClaim.new(ttl: 600, leeway: 60)],
        )
        assert_equal("***", j.secret)
        assert_equal("HS512", j.algorithm)
        assert_equal(1, j.claims.length)

        e = T.cast(j.claims[0], Jwt::ExpClaim)
        assert_equal(600, e.ttl)
        assert_equal(60, e.leeway)
      end

      def test_initialize_initializes_claims_by_value
        c = T.let([Jwt::ExpClaim.new], T::Array[Jwt::Claim])

        j = Jwt.new(secret: "***", algorithm: "HS512", claims: c)

        c.push(Jwt::IatClaim.new)

        assert_equal(1, j.claims.length)
      end

      def test_encode_encodes_with_an_empty_secret
        j = Jwt.new(secret: "", algorithm: "HS256", claims: [])

        t = j.encode({"v" => 1})

        d = decode(j, t)
        assert_equal(2, d.length)

        p = d[0]
        assert_equal(1, p.keys.length)
        assert_equal(1, p["v"])

        h = d[1]
        assert_equal(1, h.keys.length)
        assert_equal(j.algorithm, h["alg"])
      end

      def test_encode_encodes_with_a_secret
        j = Jwt.new(secret: "***", algorithm: "HS256", claims: [])

        t = j.encode({"v" => 1})

        d = decode(j, t)
        assert_equal(2, d.length)

        p = d[0]
        assert_equal(1, p.keys.length)
        assert_equal(1, p["v"])

        h = d[1]
        assert_equal(1, h.keys.length)
        assert_equal(j.algorithm, h["alg"])
      end

      def test_encode_raises_an_error_if_the_algorithm_is_absent
        j = Jwt.new(secret: "***", algorithm: "", claims: [])

        assert_raise_with_message(JWT::EncodeError, "Unsupported signing method") do
          j.encode({v: 1})
        end
      end

      def test_encode_raises_an_error_if_the_algorithm_is_unsupported
        j = Jwt.new(secret: "***", algorithm: "Unknown", claims: [])

        assert_raise_with_message(JWT::EncodeError, "Unsupported signing method") do
          j.encode({v: 1})
        end
      end

      def test_encode_includes_the_exp_claim
        j = Jwt.new(
          secret: "***",
          algorithm: "HS256",
          claims: [Jwt::ExpClaim.new(ttl: 300, leeway: 0)],
        )

        t = j.encode({"v" => 1})

        d = decode(j, t)
        assert_equal(2, d.length)

        p = d[0]
        assert_equal(2, p.keys.length)
        assert_equal(1, p["v"])
        assert_in_delta(Time.now.utc.to_i + 300, p["exp"])

        h = d[1]
        assert_equal(1, h.keys.length)
        assert_equal(j.algorithm, h["alg"])
      end

      def test_encode_ignores_the_exp_claim_if_the_ttl_is_absent
        j = Jwt.new(
          secret: "***",
          algorithm: "HS256",
          claims: [Jwt::ExpClaim.new(ttl: 0, leeway: 0)],
        )

        t = j.encode({"v" => 1})

        d = decode(j, t)
        assert_equal(2, d.length)

        p = d[0]
        assert_equal(1, p.keys.length)
        assert_equal(1, p["v"])

        h = d[1]
        assert_equal(1, h.keys.length)
        assert_equal(j.algorithm, h["alg"])
      end

      def test_encode_ignores_the_exp_claim_if_only_the_ttl_is_present
        j = Jwt.new(secret: "***", algorithm: "HS256", claims: [])

        t = j.encode({"v" => 1})

        d = decode(j, t)
        assert_equal(2, d.length)

        p = d[0]
        assert_equal(1, p.keys.length)
        assert_equal(1, p["v"])

        h = d[1]
        assert_equal(1, h.keys.length)
        assert_equal(j.algorithm, h["alg"])
      end

      def test_encode_includes_the_iat_claim
        j = Jwt.new(
          secret: "***",
          algorithm: "HS256",
          claims: [Jwt::IatClaim.new],
        )

        t = j.encode({"v" => 1})

        d = decode(j, t)
        assert_equal(2, d.length)

        p = d[0]
        assert_equal(2, p.keys.length)
        assert_equal(1, p["v"])
        assert_in_delta(Time.now.utc.to_i, p["iat"])

        h = d[1]
        assert_equal(1, h.keys.length)
        assert_equal(j.algorithm, h["alg"])
      end

      def test_encode_includes_multiple_claims
        j = Jwt.new(
          secret: "***",
          algorithm: "HS256",
          claims: [
            Jwt::ExpClaim.new(ttl: 300, leeway: 0),
            Jwt::IatClaim.new,
          ],
        )

        t = j.encode({"v" => 1})

        d = decode(j, t)
        assert_equal(2, d.length)

        p = d[0]
        assert_equal(3, p.keys.length)
        assert_equal(1, p["v"])
        assert_in_delta(Time.now.utc.to_i + 300, p["exp"])
        assert_in_delta(Time.now.utc.to_i, p["iat"])

        h = d[1]
        assert_equal(1, h.keys.length)
        assert_equal(j.algorithm, h["alg"])
      end

      def test_encode_does_not_mutate_the_payload
        j = Jwt.new(
          secret: "***",
          algorithm: "HS256",
          claims: [Jwt::ExpClaim.new(ttl: 300, leeway: 0)],
        )

        p = {"v" => 1, "exp" => 1}
        t = j.encode(p)
        assert_equal(2, p.keys.length)
        assert_equal(1, p["v"])
        assert_equal(1, p["exp"])

        d = decode(j, t)
        assert_equal(2, d.length)

        p = d[0]
        assert_equal(2, p.keys.length)
        assert_equal(1, p["v"])
        assert_in_delta(Time.now.utc.to_i + 300, p["exp"])

        h = d[1]
        assert_equal(1, h.keys.length)
        assert_equal(j.algorithm, h["alg"])
      end

      def test_encode_body_encodes
        j = Jwt.new(secret: "***", algorithm: "HS256", claims: [])

        b = j.encode_body({"v" => 1})
        assert_equal(2, b.keys.length)
        assert_equal(1, b["v"])

        d = decode(j, b["token"])
        assert_equal(2, d.length)

        p = d[0]
        assert_equal(1, p.keys.length)
        assert_equal(1, p["v"])

        h = d[1]
        assert_equal(1, h.keys.length)
        assert_equal(j.algorithm, h["alg"])
      end

      def test_encode_body_does_not_mutate_the_payload
        j = Jwt.new(secret: "***", algorithm: "HS256", claims: [])

        p = {"v" => 1, "token" => "***"}
        b = j.encode_body(p)
        assert_equal(2, p.keys.length)
        assert_equal(1, p["v"])
        assert_equal("***", p["token"])

        d = decode(j, b["token"])
        assert_equal(2, d.length)

        p = d[0]
        assert_equal(2, p.keys.length)
        assert_equal(1, p["v"])
        assert_equal("***", p["token"])

        h = d[1]
        assert_equal(1, h.keys.length)
        assert_equal(j.algorithm, h["alg"])
      end

      def test_encode_header_encodes
        j = Jwt.new(secret: "***", algorithm: "HS256", claims: [])

        h = j.encode_header("v")

        d = decode(j, h)
        assert_equal(2, d.length)

        p = d[0]
        assert_equal(1, p.keys.length)
        assert_equal("v", p["payload"])

        h = d[1]
        assert_equal(1, h.keys.length)
        assert_equal(j.algorithm, h["alg"])
      end

      def test_encode_uri_encodes
        j = Jwt.new(secret: "***", algorithm: "HS256", claims: [])

        u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
        n = j.encode_uri(u)

        q = T.cast(n.query, String)
        f = URI.decode_www_form(q)

        c = T.cast(f.assoc("token"), [String, String])
        t = c[1]

        d = decode(j, t)
        assert_equal(2, d.length)

        p = d[0]
        assert_equal(1, p.keys.length)
        assert_equal(u.to_s, p["url"])

        h = d[1]
        assert_equal(1, h.keys.length)
        assert_equal(j.algorithm, h["alg"])
      end

      def test_encode_uri_preserves_the_query
        j = Jwt.new(secret: "***", algorithm: "HS256", claims: [])

        u = T.cast(URI.parse("http://localhost:8080/?v=1"), URI::HTTP)
        n = j.encode_uri(u)

        q = T.cast(n.query, String)
        f = URI.decode_www_form(q)

        c = T.cast(f.assoc("v"), [String, String])
        assert_equal(["v", "1"], c)

        c = T.cast(f.assoc("token"), [String, String])
        t = c[1]

        d = decode(j, t)
        assert_equal(2, d.length)

        p = d[0]
        assert_equal(1, p.keys.length)
        assert_equal(u.to_s, p["url"])

        h = d[1]
        assert_equal(1, h.keys.length)
        assert_equal(j.algorithm, h["alg"])
      end

      def test_encode_uri_does_not_mutate_the_query
        j = Jwt.new(secret: "***", algorithm: "HS256", claims: [])

        u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
        n = j.encode_uri(u)

        q = u.query
        assert_nil(q)

        q = T.cast(n.query, String)
        f = URI.decode_www_form(q)

        c = T.cast(f.assoc("token"), [String, String])
        t = c[1]

        d = decode(j, t)
        assert_equal(2, d.length)

        p = d[0]
        assert_equal(1, p.keys.length)
        assert_equal(u.to_s, p["url"])

        h = d[1]
        assert_equal(1, h.keys.length)
        assert_equal(j.algorithm, h["alg"])
      end

      def test_decode_decodes
        j = Jwt.new(secret: "***", algorithm: "HS256", claims: [])

        t = j.encode({"v" => 1})

        p = j.decode(t)
        assert_equal(1, p.keys.length)
        assert_equal(1, p["v"])
      end

      def test_decode_does_not_include_claims_in_the_payload
        j = Jwt.new(
          secret: "***",
          algorithm: "HS256",
          claims: [
            Jwt::ExpClaim.new(ttl: 300, leeway: 0),
            Jwt::IatClaim.new,
          ],
        )

        t = j.encode({"v" => 1})

        p = j.decode(t)
        assert_equal(1, p.keys.length)
        assert_equal(1, p["v"])
      end

      def test_decode_raises_an_error_if_the_token_is_empty
        j = Jwt.new(secret: "***", algorithm: "HS256", claims: [])

        assert_raise_with_message(JWT::DecodeError, "Not enough or too many segments") do
          j.decode("")
        end
      end

      def test_decode_raises_an_error_if_the_token_is_invalid
        j = Jwt.new(secret: "***", algorithm: "HS256", claims: [])

        assert_raise_with_message(JWT::DecodeError, "Not enough or too many segments") do
          j.decode("invalid")
        end
      end

      def test_decode_raises_an_error_if_a_different_algorithm_is_used
        j = Jwt.new(secret: "***", algorithm: "HS256", claims: [])

        t = j.encode({"v" => 1})

        j = Jwt.new(secret: "***", algorithm: "HS512", claims: [])

        assert_raise_with_message(JWT::IncorrectAlgorithm, "Expected a different algorithm") do
          j.decode(t)
        end
      end

      def test_decode_raises_an_error_if_the_signature_has_expired
        j = Jwt.new(
          secret: "***",
          algorithm: "HS256",
          claims: [Jwt::ExpClaim.new(ttl: 1, leeway: 0)],
        )

        t = j.encode({"v" => 1})

        sleep(1)

        assert_raise_with_message(JWT::ExpiredSignature, "Signature has expired") do
          j.decode(t)
        end
      end

      def test_decode_does_not_raise_an_error_if_the_signature_has_expired_within_the_leeway
        j = Jwt.new(
          secret: "***",
          algorithm: "HS256",
          claims: [Jwt::ExpClaim.new(ttl: 1, leeway: 10)],
        )

        t = j.encode({"v" => 1})

        sleep(1)

        p = j.decode(t)
        assert_equal(1, p.keys.length)
        assert_equal(1, p["v"])
      end

      def test_decode_body_decodes
        j = Jwt.new(secret: "***", algorithm: "HS256", claims: [])

        b = j.encode_body({"v" => 1})

        b = j.decode_body(b)
        assert_equal(1, b.keys.length)
        assert_equal(1, b["v"])
      end

      def test_decode_body_raises_an_error_if_the_body_does_not_have_a_token
        j = Jwt.new(secret: "***", algorithm: "HS256", claims: [])

        assert_raise_with_message(KeyError, "Expected the body to have a 'token' key, but it did not") do
          j.decode_body({})
        end
      end

      def test_decode_body_raises_an_error_if_the_token_is_not_a_string
        j = Jwt.new(secret: "***", algorithm: "HS256", claims: [])

        assert_raise_with_message(TypeError, "Expected the 'token' key to be a String, but it was a Integer") do
          j.decode_body({"token" => 1})
        end
      end

      def test_decode_header_decodes
        j = Jwt.new(secret: "***", algorithm: "HS256", claims: [])

        h = j.encode_header("v")

        h = j.decode_header(h)
        assert_equal("v", h)
      end

      def test_decode_header_raises_an_error_if_the_header_does_not_have_a_payload
        j = Jwt.new(secret: "***", algorithm: "HS256", claims: [])

        h = encode(j, {"v" => 1})

        assert_raise_with_message(KeyError, "Expected the decoded header to have a 'payload' key, but it did not") do
          j.decode_header(h)
        end
      end

      def test_decode_uri_decodes
        j = Jwt.new(secret: "***", algorithm: "HS256", claims: [])

        u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
        n = j.encode_uri(u)

        u = j.decode_uri(n)
        assert_equal("http://localhost:8080/", u.to_s)
      end

      def test_decode_uri_raises_an_error_if_the_uri_does_not_have_a_query_string
        j = Jwt.new(secret: "***", algorithm: "HS256", claims: [])

        u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)

        assert_raise_with_message(ArgumentError, "Expected the URI to have a query string, but it did not") do
          j.decode_uri(u)
        end
      end

      def test_decode_uri_raises_an_error_if_the_query_string_does_not_have_a_token
        j = Jwt.new(secret: "***", algorithm: "HS256", claims: [])

        u = T.cast(URI.parse("http://localhost:8080/?v=1"), URI::HTTP)

        assert_raise_with_message(KeyError, "Expected the query string to have a 'token' key, but it did not") do
          j.decode_uri(u)
        end
      end

      def test_decode_uri_raises_an_error_if_the_decoded_token_does_not_have_a_url
        j = Jwt.new(secret: "***", algorithm: "HS256", claims: [])

        u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
        f = URI.decode_www_form("")
        f.append(["token", j.encode({"v" => 1})])
        u.query = URI.encode_www_form(f)

        assert_raise_with_message(KeyError, "Expected the decoded token to have a 'url' key, but it did not") do
          j.decode_uri(u)
        end
      end

      def test_decode_uri_raises_an_error_if_the_url_is_not_a_string
        j = Jwt.new(secret: "***", algorithm: "HS256", claims: [])

        u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
        f = URI.decode_www_form("")
        f.append(["token", j.encode({"url" => 1})])
        u.query = URI.encode_www_form(f)

        assert_raise_with_message(TypeError, "Expected the 'url' key to be a String, but it was a Integer") do
          j.decode_uri(u)
        end
      end

      def test_decode_uri_raises_an_error_if_the_url_is_not_a_uri_http
        j = Jwt.new(secret: "***", algorithm: "HS256", claims: [])

        u = T.cast(URI.parse("http://localhost:8080/"), URI::HTTP)
        f = URI.decode_www_form("")
        f.append(["token", j.encode({"url" => "sftp://localhost:8080/"})])
        u.query = URI.encode_www_form(f)

        assert_raise_with_message(TypeError, "Expected the 'url' key to be a URI::HTTP, but it was a URI::Generic") do
          j.decode_uri(u)
        end
      end

      sig {params(j: Jwt, p: T.untyped).returns(T.untyped)}
      def encode(j, p)
        JWT.encode(p, j.secret, j.algorithm)
      end

      sig {params(j: Jwt, t: String).returns(T.untyped)}
      def decode(j, t)
        JWT.decode(t, j.secret, true, {algorithm: j.algorithm})
      end
    end
  end
end
