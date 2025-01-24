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

require "sorbet-runtime"
require_relative "../../jwt"

module Onlyoffice
  module DocsIntegrationSdk
    module DocumentServer
      class Client
        # Jwt is a class that represents the JWT token configuration for the
        # Document Server client.
        #
        # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/signature/)
        #
        # @since 0.1.0
        class Jwt
          extend T::Sig

          # Location is an enum that represents the location of the JWT token in
          # the request.
          #
          # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/signature/request/)
          #
          # @since 0.1.0
          class Location < T::Enum
            enums do
              # Header is the location of the JWT token in the request header.
              #
              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/signature/request/token-in-header/)
              #
              # @since 0.1.0
              Header = new("header")

              # Body is the location of the JWT token in the request body.
              #
              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/signature/request/token-in-body/)
              #
              # @since 0.1.0
              Body = new("body")
            end
          end

          # jwt is the JWT token encoding configuration.
          #
          # @since 0.1.0
          sig {returns(JwtEncoding)}
          attr_reader :jwt

          # locations is the list of locations of the JWT token in the request.
          #
          # @since 0.1.0
          sig {returns(T::Array[Location])}
          attr_reader :locations

          # header is the header name of the JWT token in the request.
          #
          # @example
          #   req[jwt.header] = "#{jwt.schema} #{jwt.jwt.encode_header(payload)}"
          #
          # @since 0.1.0
          sig {returns(String)}
          attr_reader :header

          # schema is the schema of the JWT token in the request.
          #
          # @example
          #   req[jwt.header] = "#{jwt.schema} #{jwt.jwt.encode_header(payload)}"
          #
          # @since 0.1.0
          sig {returns(String)}
          attr_reader :schema

          # initialize initializes a new Jwt instance. It makes a shallow copy
          # of the locations list.
          #
          # @param jwt
          #   The JWT token encoding configuration.
          # @param locations
          #   The list of locations of the JWT token in the request.
          # @param header
          #   The header name of the JWT token in the request.
          # @param schema
          #   The schema of the JWT token in the request.
          sig do
            params(
              jwt: JwtEncoding,
              locations: T::Array[Location],
              header: String,
              schema: String,
            ).void
          end
          def initialize(
            jwt:,
            locations: [Location::Header, Location::Body],
            header: "Authorization",
            schema: "Bearer"
          )
            @jwt = jwt
            @locations = T.let(locations.clone, T::Array[Location])
            @header = header
            @schema = schema
          end
        end
      end
    end
  end
end
