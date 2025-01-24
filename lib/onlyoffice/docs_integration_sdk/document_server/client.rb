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
require "net/http"
require "sorbet-runtime"
require_relative "client/command"
require_relative "client/conversion"
require_relative "client/healthcheck"
require_relative "client/jwt"
require_relative "client/response"
require_relative "client/service"
require_relative "client/ua"

module Onlyoffice
  module DocsIntegrationSdk
    module DocumentServer
      # Client is a class that provides a way to interact with the Document
      # Server API. It acts as a wrapper around the Net::HTTP class, offering a
      # more convenient method for interacting with the API.
      #
      # @since 0.1.0
      class Client
        extend T::Sig

        # http is a Net::HTTP that is used to make requests to the Document
        # Server. This should only be used for requests to the Document Server,
        # because requests may contain a JWT token. It stores a shallow copy of
        # the original instance.
        #
        # @since 0.1.0
        sig {returns(Net::HTTP)}
        def http
          @http.clone
        end

        # @since 0.1.0
        sig {returns(Net::HTTP)}
        protected def http!
          @http
        end

        # base_uri is a base URL of the Document Server. It is used to build the
        # full URL of the request. It stores a shallow copy of the original
        # instance.
        #
        # @since 0.1.0
        sig {returns(URI::HTTP)}
        def base_uri
          @base_uri.clone
        end

        # user_agent is a User-Agent that is used to make requests to the
        # Document Server.
        #
        # @since 0.1.0
        sig {returns(String)}
        def user_agent
          @user_agent
        end

        # command is a CommandService that is used to interact with the Command
        # Service API.
        #
        # @since 0.1.0
        sig {returns(CommandService)}
        attr_reader :command

        # conversion is a ConversionService that is used to interact with the
        # Conversion Service API.
        #
        # @since 0.1.0
        sig {returns(ConversionService)}
        attr_reader :conversion

        # healthcheck is a HealthcheckService that is used to interact with the
        # Healthcheck Service API.
        #
        # @since 0.1.0
        sig {returns(HealthcheckService)}
        attr_reader :healthcheck

        # initialize initializes a new Client instance. It requires either http
        # or base_uri to be provided. If only one of them is provided, the other
        # one will be built from the provided one. If user_agent is not
        # provided, it will default to the {USER_AGENT} constant. It makes a
        # shallow copy of the provided instances.
        #
        # @param http
        #   The Net::HTTP instance that is used to make requests to the Document
        #   Server.
        # @param base_uri
        #   The base URI of the Document Server.
        # @param user_agent
        #   The User-Agent that is used to make requests to the Document Server.
        #
        # @raise [ArgumentError] If neither http nor base_uri is provided.
        #
        # @since 0.1.0
        sig {params(http: T.nilable(Net::HTTP), base_uri: T.nilable(URI::HTTP), user_agent: T.nilable(String)).void}
        def initialize(http: nil, base_uri: nil, user_agent: nil)
          if !http && !base_uri
            raise ArgumentError, "Either http or base_uri must be provided"
          end

          if http && base_uri
            @http = T.let(http.clone, Net::HTTP)
            @base_uri = T.let(base_uri.clone, URI::HTTP)
          elsif http
            @http = T.let(http.clone, Net::HTTP)
            @base_uri = T.let(URI::HTTP.build(host: @http.address, port: @http.port), URI::HTTP)
          elsif base_uri
            @http = T.let(Net::HTTP.new(base_uri.host, base_uri.port), Net::HTTP)
            @base_uri = T.let(base_uri.clone, URI::HTTP)
          end

          if user_agent
            @user_agent = T.let(user_agent, String)
          else
            @user_agent = T.let(USER_AGENT, String)
          end

          @command = T.let(CommandService.new(client: self), CommandService)
          @conversion = T.let(ConversionService.new(client: self), ConversionService)
          @healthcheck = T.let(HealthcheckService.new(client: self), HealthcheckService)
        end

        # with_jwt creates a new Client instance with the provided JWT
        # configuration. It modifies the Net::HTTP#request method to add the JWT
        # token to the request. The JWT token is added to the request based on
        # the locations provided in the JWT configuration.
        #
        # @param jwt The JWT configuration that is used to sign requests.
        # @return A new Client instance with the JWT configuration applied.
        # @since 0.1.0
        sig {params(jwt: Jwt).returns(Client)}
        def with_jwt(jwt)
          # The idea of this approach has its roots in the practice of Go, where
          # you can implement your own http.Transport. Unfortunately, Ruby does
          # not have a direct equivalent of http.Transport, so you have to create
          # a sort of patch for the request method.
          #
          # https://pkg.go.dev/net/http@go1.23.5/#Transport
          # https://github.com/ruby/ruby/blob/v3_4_1/lib/net/http.rb/#L2367

          r = @http.method(:request)
          c = copy

          c.http!.define_singleton_method(:request) do |req, body = nil, &block|
            req = T.let(req, Net::HTTPRequest)

            if (req.body || req.body_stream) && body
              # Leave it untouched so Ruby can raise an error.
              # https://github.com/ruby/ruby/blob/v3_4_1/lib/net/http/generic_request.rb/#L186
            elsif req.body
              if !jwt.locations.empty?
                b = JSON.parse(req.body)

                if jwt.locations.include?(Jwt::Location::Header)
                  p = jwt.jwt.encode_header(b)
                  req[jwt.header] = "#{jwt.schema} #{p}"
                end

                if jwt.locations.include?(Jwt::Location::Body)
                  p = jwt.jwt.encode_body(b)
                  req.body = p.to_json
                end
              end
            elsif req.body_stream
              # todo: implement
            elsif body
              # todo: cover with tests
              if !jwt.locations.empty?
                b = JSON.parse(body)

                if jwt.locations.include?(Jwt::Location::Header)
                  p = jwt.jwt.encode_header(b)
                  req[jwt.header] = "#{jwt.schema} #{p}"
                end

                if jwt.locations.include?(Jwt::Location::Body)
                  p = jwt.jwt.encode_body(b)
                  body = p.to_json
                end
              end
            end

            r.call(req, body, &block)
          end

          c
        end

        # @since 0.1.0
        sig {returns(Client)}
        protected def copy
          self.class.new(
            base_uri: @base_uri,
            http: @http,
            user_agent: @user_agent,
          )
        end

        # get makes a GET request to the Document Server. It is a wrapper around
        # the {uri}, {request} and {do} methods.
        #
        # @param p The path to join with the base URI.
        # @return Inherited from {do}.
        # @since 0.1.0
        sig {params(p: String).returns([T.untyped, Response])}
        def get(p)
          u = uri(p)
          r = request(Net::HTTP::Get, u)
          self.do(r)
        end

        # post makes a POST request to the Document Server. It is a wrapper
        # around the {uri}, {request} and {do} methods.
        #
        # @param p The path to join with the base URI.
        # @param b The body of the request.
        # @return Inherited from {do}
        # @since 0.1.0
        sig {params(p: String, b: T.untyped).returns([T.untyped, Response])}
        def post(p, b = nil)
          u = uri(p)
          r = request(Net::HTTP::Post, u, b)
          self.do(r)
        end

        # uri creates a new URI::HTTP instance by joining the base URI with the
        # provided path.
        #
        # @param p The path to join with the base URI.
        # @return A new URI::HTTP instance.
        # @since 0.1.0
        sig {params(p: String).returns(URI::HTTP)}
        def uri(p)
          # The URI.join returns a URI in the same implementation as the first
          # argument. Therefore, calling T.cast is safe because the @base_url is a
          # URI::HTTP and the result will be a URI::HTTP.
          T.cast(URI.join(@base_uri.to_s, p), URI::HTTP)
        end

        # request creates a new Net::HTTPRequest instance with the provided
        # method, URI, and body.
        #
        # @param m The method of the request.
        # @param u The URI of the request.
        # @param b The body of the request.
        # @return A new Net::HTTPRequest instance.
        # @since 0.1.0
        sig {params(m: T.class_of(Net::HTTPRequest), u: URI::HTTP, b: T.untyped).returns(Net::HTTPRequest)}
        def request(m, u, b = nil)
          r = m.new(u)

          r["Accept"] = "application/json"
          r["User-Agent"] = @user_agent

          if b
            r["Content-Type"] = "application/json"
            r.body = b.to_json
          end

          r
        end

        # do makes a request to the Document Server. It returns a tuple with the
        # body of the response and the response instance.
        #
        # @param req
        #   The Net::HTTPRequest that is used to make the request.
        #
        # @return
        #   A tuple with the body of the response and the response instance.
        #
        # @since 0.1.0
        sig {params(req: Net::HTTPRequest).returns([T.untyped, Response])}
        def do(req)
          err = T.let(nil, T.untyped)
          b = T.let(nil, T.untyped)

          # Document Server always returns a response with the status 200, so
          # there is no need to check for any other statuses.

          raw = T.let(@http.request(req), Net::HTTPResponse)

          begin
            b = JSON.parse(raw.body)
          rescue StandardError => e
            err = e
          end

          res = Response.new(request: req, response: raw, error: err)

          [b, res]
        end
      end
    end
  end
end
