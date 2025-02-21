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
require_relative "../../test_test"
require_relative "jwt"

module Onlyoffice
  module DocsIntegrationSdk
    module DocumentServer
      class Client
        class Jwt
          class LocationTest < ::Test::Unit::TestCase
            extend T::Sig
            include Test::BasicEnumMarshalling

            sig {override.returns(T::Array[[String, Location]])}
            def cases
              [
                ["header", Location::Header],
                ["body", Location::Body],
              ]
            end
          end
        end

        class JwtTest < ::Test::Unit::TestCase
          def test_initialize_initializes_with_default_values
            w = DocsIntegrationSdk::Jwt.new(secret: "***")
            j = Jwt.new(jwt: w)
            assert_equal(w, j.jwt)
            assert_equal([Jwt::Location::Header, Jwt::Location::Body], j.locations)
            assert_equal("Authorization", j.header)
            assert_equal("Bearer", j.schema)
          end

          def test_initialize_initializes_with_custom_values
            w = DocsIntegrationSdk::Jwt.new(secret: "***")
            j = Jwt.new(
              jwt: w,
              locations: [Jwt::Location::Body],
              header: "X-Auth",
              schema: "Token"
            )
            assert_equal(w, j.jwt)
            assert_equal([Jwt::Location::Body], j.locations)
            assert_equal("X-Auth", j.header)
            assert_equal("Token", j.schema)
          end
        end
      end
    end
  end
end
