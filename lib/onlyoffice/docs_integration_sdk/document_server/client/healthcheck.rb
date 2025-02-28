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

# typed: false
# frozen_string_literal: true

require "sorbet-runtime"
require_relative "response"
require_relative "service"

module Onlyoffice
  module DocsIntegrationSdk
    module DocumentServer
      class Client
        # HealthcheckServing is an interface that describes the methods that
        # must be implemented to be considered a healthcheck service.
        #
        # @since 0.1.0
        module HealthcheckServing
          extend T::Sig
          extend T::Helpers
          interface!

          sig {abstract.returns(Response)}
          def do; end
        end

        # HealthcheckService is an implementation of the {HealthcheckServing}
        # interface.
        #
        # @since 0.1.0
        class HealthcheckService < Service
          include HealthcheckServing

          # Error is an enum that represents the possible errors that can occur
          # when using the healthcheck service.
          #
          # @since 0.1.0
          class Error < T::Enum
            extend T::Sig

            enums do
              # @since 0.1.0
              Failed = new(-1)
            end

            # description returns the human-readable description of the error.
            #
            # @since 0.1.0
            sig {returns(String)}
            def description
              case self
              when Failed
                "Healthcheck failed"
              else
                # :nocov:
                # unreachable
                # :nocov:
              end
            end
          end

          # do makes a healthcheck request to the Document Server.
          #
          # @return A response
          # @since 0.1.0
          sig {override.returns(Response)}
          def do
            c, res = @client.get("healthcheck")
            if res.error
              return res
            end

            if !c.is_a?(TrueClass)
              res = Response.new(
                request: res.request,
                response: res.response,
                error: Error::Failed,
              )
            end

            res
          end
        end
      end
    end
  end
end
