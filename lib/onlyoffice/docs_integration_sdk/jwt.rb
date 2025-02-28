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

require "json"
require "jwt"
require "sorbet-runtime"
require "uri"

module Onlyoffice
  module DocsIntegrationSdk
    # JwtEncoding is an interface that describes methods that must be
    # implemented to be considered a JWT encoder.
    #
    # @since 0.1.0
    module JwtEncoding
      extend T::Sig
      extend T::Helpers
      interface!

      # @param u The URI to encode.
      # @return An encoded URI.
      # @since 0.1.0
      sig {abstract.params(u: URI::HTTP).returns(URI::HTTP)}
      def encode_uri(u); end

      # @param p The payload to encode.
      # @return An encoded header.
      # @since 0.1.0
      sig {abstract.params(p: T.untyped).returns(String)}
      def encode_header(p); end

      # @param p The payload to encode.
      # @return An encoded body.
      # @since 0.1.0
      sig {abstract.params(p: T::Hash[T.untyped, T.untyped]).returns(T::Hash[T.untyped, T.untyped])}
      def encode_body(p); end

      # @param p The payload to encode.
      # @return An encoded token.
      # @since 0.1.0
      sig {abstract.params(p: T::Hash[T.untyped, T.untyped]).returns(String)}
      def encode(p); end
    end

    # JwtDecoding is an interface that describes methods that must be
    # implemented to be considered a JWT decoder.
    #
    # @since 0.1.0
    module JwtDecoding
      extend T::Sig
      extend T::Helpers
      interface!

      # @param u The URI to decode.
      # @return A decoded URI.
      # @since 0.1.0
      sig {abstract.params(u: URI::HTTP).returns(URI::HTTP)}
      def decode_uri(u); end

      # @param h The header to decode.
      # @return A decoded header.
      # @since 0.1.0
      sig {abstract.params(h: String).returns(T.untyped)}
      def decode_header(h); end

      # @param b The body to decode.
      # @return A decoded body.
      # @since 0.1.0
      sig {abstract.params(b: T::Hash[T.untyped, T.untyped]).returns(T::Hash[T.untyped, T.untyped])}
      def decode_body(b); end

      # @param t The token to decode.
      # @return A decoded token.
      # @since 0.1.0
      sig {abstract.params(t: String).returns(T::Hash[T.untyped, T.untyped])}
      def decode(t); end
    end

    # JwtCoding is an interface that describes methods that must be
    # implemented to be considered a JWT encoder and decoder.
    #
    # @since 0.1.0
    module JwtCoding
      extend T::Sig
      extend T::Helpers
      include JwtEncoding
      include JwtDecoding
      interface!
    end

    # Jwt is an implementation of the {JwtCoding} interface. Under the hood, it
    # uses Ruby JWT library to encode and decode JSON Web Tokens.
    #
    # This class has its own set of known claims. If an unfamiliar claim is
    # passed to the class during its initialization, it will not be considered.
    #
    # Before the encoding process by Ruby JWT, this class forms a claims list.
    # The {ExpClaim} will be included in the list only if its {ExpClaim.ttl} is
    # not zero, otherwise it will be ignored.
    #
    # Before the decoding process by Ruby JWT, this class forms a claims list.
    # The {ExpClaim} will be included in the list only if its {ExpClaim.leeway}
    # is not zero, otherwise it will be ignored.
    #
    # [RFC 7519 Reference](https://datatracker.ietf.org/doc/html/rfc7519/),
    # [Ruby JWT Reference](https://github.com/jwt/ruby-jwt/)
    #
    # @since 0.1.0
    class Jwt
      extend T::Sig
      include JwtCoding

      # Claim is an interface for claims that can be added to a JWT.
      #
      # [RFC 7519 Reference](https://datatracker.ietf.org/doc/html/rfc7519/#section-4.1)
      #
      # @since 0.1.0
      module Claim
        extend T::Sig
        extend T::Helpers
        include Kernel
        interface!
      end

      # ExpClaim is a claim that represents the expiration time of a JWT.
      #
      # [RFC 7519 Reference](https://datatracker.ietf.org/doc/html/rfc7519/#section-4.1.4)
      #
      # @since 0.1.0
      class ExpClaim
        extend T::Sig
        include Claim

        # ttl is the time allowed for the token to be valid, measured in
        # seconds.
        #
        # @since 0.1.0
        sig {returns(Integer)}
        attr_reader :ttl

        # leeway is the time allowed to account for clock skew, measured in
        # seconds.
        #
        # @since 0.1.0
        sig {returns(Integer)}
        attr_reader :leeway

        # initialize initializes a new ExpClaim instance.
        #
        # @param ttl
        #   The time allowed for the token to be valid, measured in seconds.
        # @param leeway
        #   The time allowed to account for clock skew, measured in seconds.
        #
        # @since 0.1.0
        sig {params(ttl: Integer, leeway: Integer).void}
        def initialize(ttl: 300, leeway: 30)
          @ttl = ttl
          @leeway = leeway
        end
      end

      # IatClaim is a claim that represents the time at which the JWT was
      # issued.
      #
      # [RFC 7519 Reference](https://datatracker.ietf.org/doc/html/rfc7519/#section-4.1.6)
      #
      # @since 0.1.0
      class IatClaim
        extend T::Sig
        include Claim

        # initialize initializes a new IatClaim instance.
        #
        # @since 0.1.0
        sig {void}
        def initialize; end
      end

      # secret is the secret key used to encode and decode JWTs.
      #
      # @since 0.1.0
      sig {returns(String)}
      attr_reader :secret

      # algorithm is the algorithm used to encode and decode JWTs.
      #
      # @since 0.1.0
      sig {returns(String)}
      attr_reader :algorithm

      # claims is the list of claims to add to the JWT.
      #
      # @since 0.1.0
      sig {returns(T::Array[Claim])}
      attr_reader :claims

      # initialize initializes a new Jwt instance. It makes a shallow copy of
      # the claims list.
      #
      # @param secret The secret key used to encode and decode JWTs.
      # @param algorithm The algorithm used to encode and decode JWTs.
      # @param claims The list of claims to add to the JWT.
      # @since 0.1.0
      sig {params(secret: String, algorithm: String, claims: T::Array[Claim]).void}
      def initialize(secret:, algorithm: "HS256", claims: [ExpClaim.new, IatClaim.new])
        @secret = secret
        @algorithm = algorithm
        @claims = T.let(claims.clone, T::Array[Claim])
      end

      # encode_uri encodes a URI by adding a token to the query string. This
      # method returns a shallow copy of the URI with the token added. It does
      # not modify the original URI.
      #
      # @example
      #   uri = jwt.encode_uri(uri)
      #
      # @param u The URI to encode.
      # @return An encoded URI.
      # @raise Inherited from {encode}.
      # @since 0.1.0
      sig {override.params(u: URI::HTTP).returns(URI::HTTP)}
      def encode_uri(u)
        u = u.clone

        q = u.query
        if q.nil?
          q = ""
        end

        f = URI.decode_www_form(q)

        t = encode({"url" => u.to_s})
        f.append(["token", t])

        u.query = URI.encode_www_form(f)

        u
      end

      # encode_header encodes a payload by adding a token to the header.
      #
      # @example
      #   req["Authorization"] = "Bearer #{jwt.encode_header(payload)}"
      #
      # @param p The payload to encode.
      # @return An encoded header.
      # @raise Inherited from {encode}.
      # @since 0.1.0
      sig {override.params(p: T.untyped).returns(String)}
      def encode_header(p)
        encode({"payload" => p})
      end

      # encode_body encodes a payload by adding a token to the body. This method
      # returns a shallow copy of the payload with the token added. It does not
      # modify the original payload.
      #
      # @example
      #   req.body = jwt.encode_body(payload).to_json
      #
      # @param p The payload to encode.
      # @return An encoded body.
      # @raise Inherited from {encode}.
      # @since 0.1.0
      sig {override.params(p: T::Hash[T.untyped, T.untyped]).returns(T::Hash[T.untyped, T.untyped])}
      def encode_body(p)
        p = p.clone
        p["token"] = encode(p)
        p
      end

      # encode encodes a payload.
      #
      # @example
      #   token = jwt.encode(payload)
      #
      # @param p The payload to encode
      # @return An encoded token.
      # @raise Inherited from JWT.encode of Ruby JWT.
      # @since 0.1.0
      sig {override.params(p: T::Hash[T.untyped, T.untyped]).returns(String)}
      def encode(p)
        p = p.clone

        t = Time.now.utc.to_i

        for c in @claims
          if c.is_a?(ExpClaim) && c.ttl != 0
            p["exp"] = t + c.ttl
            next
          end

          if c.is_a?(IatClaim)
            p["iat"] = t
            next
          end
        end

        JWT.encode(p, @secret, @algorithm)
      end

      # decode_uri decodes a URI by extracting a token from the query string.
      # This method returns a shallow copy of the URI with the token removed. It
      # does not modify the original URI.
      #
      # @example
      #   uri = jwt.decode_uri(uri)
      #
      # @param u The URI to decode
      # @return A decoded URI
      # @raise [ArgumentError] If the URI does not have a query string.
      # @raise [KeyError] If the query string does not have a 'token' key.
      # @raise [KeyError] If the decoded token does not have a 'url' key.
      # @raise [TypeError] If the 'url' key is not a String.
      # @raise [TypeError] If the 'url' key is not a URI::HTTP.
      # @raise Inherited from {decode}.
      # @since 0.1.0
      sig {override.params(u: URI::HTTP).returns(URI::HTTP)}
      def decode_uri(u)
        q = u.query
        if q.nil?
          raise ArgumentError, "Expected the URI to have a query string, but it did not"
        end

        f = URI.decode_www_form(q)

        c = f.assoc("token")
        if !c
          raise KeyError, "Expected the query string to have a 'token' key, but it did not"
        end

        t = c[1]

        d = decode(t)
        if !d.key?("url")
          raise KeyError, "Expected the decoded token to have a 'url' key, but it did not"
        end

        s = d["url"]
        if !s.is_a?(String)
          raise TypeError, "Expected the 'url' key to be a String, but it was a #{s.class}"
        end

        g = URI.parse(s)
        if !g.is_a?(URI::HTTP)
          raise TypeError, "Expected the 'url' key to be a URI::HTTP, but it was a #{g.class}"
        end

        g
      end

      # decode_header decodes a header.
      #
      # @example
      #   header = "Bearer ***"
      #   payload = jwt.decode_header(header[7..])
      #
      # @param h The header to decode
      # @return A decoded header
      # @raise [KeyError] If the decoded header does not have a 'payload' key.
      # @raise Inherited from {decode}.
      sig {override.params(h: String).returns(T.untyped)}
      def decode_header(h)
        d = decode(h)
        if !d.key?("payload")
          raise KeyError, "Expected the decoded header to have a 'payload' key, but it did not"
        end

        d["payload"]
      end

      # decode_body decodes a body by extracting a token from the body. This
      # method returns a shallow copy of the body with the token removed. It
      # does not modify the original body.
      #
      # @example
      #   json = JSON.parse(res.body)
      #   payload = jwt.decode_body(json)
      #
      # @param b The body to decode.
      # @return A decoded body.
      # @raise [KeyError] If the body does not have a 'token' key.
      # @raise [TypeError] If the 'token' key is not a String.
      # @raise Inherited from {decode}.
      sig {override.params(b: T::Hash[T.untyped, T.untyped]).returns(T::Hash[T.untyped, T.untyped])}
      def decode_body(b)
        if !b.key?("token")
          raise KeyError, "Expected the body to have a 'token' key, but it did not"
        end

        t = b["token"]
        if !t.is_a?(String)
          raise TypeError, "Expected the 'token' key to be a String, but it was a #{t.class}"
        end

        decode(t)
      end

      # decode decodes a token.
      #
      # @example
      #   payload = jwt.decode(token)
      #
      # @param t The token to decode.
      # @return A decoded token.
      # @raise Inherited from JWT.decode of Ruby JWT.
      sig {override.params(t: String).returns(T::Hash[T.untyped, T.untyped])}
      def decode(t)
        o = T.let({}, T::Hash[Symbol, T.untyped])

        o[:algorithm] = @algorithm

        for c in @claims
          if c.is_a?(ExpClaim) && c.leeway != 0
            o[:exp_leeway] = c.leeway
            next
          end
        end

        d, _ = JWT.decode(t, @secret, true, o)
        d = T.cast(d, T::Hash[T.untyped, T.untyped])

        d.delete("exp")
        d.delete("iat")

        d
      end
    end
  end
end
