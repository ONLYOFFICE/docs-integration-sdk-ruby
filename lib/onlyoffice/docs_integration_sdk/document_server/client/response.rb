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

require "net/http"
require "sorbet-runtime"

module Onlyoffice
  module DocsIntegrationSdk
    module DocumentServer
      class Client
        # Response is a class that represents the response from the Document
        # Server.
        #
        # @since 0.1.0
        class Response
          extend T::Sig

          # request is the request that was sent to the Document Server.
          #
          # @since 0.1.0
          sig {returns(Net::HTTPRequest)}
          attr_reader :request

          # response is the response from the Document Server.
          #
          # @since 0.1.0
          sig {returns(Net::HTTPResponse)}
          attr_reader :response

          # error is the error that occurred when sending the request.
          #
          # @since 0.1.0
          sig {returns(T.nilable(Object))}
          attr_reader :error

          # initialize initializes a new Response instance.
          #
          # @param request The request that was sent to the Document Server.
          # @param response The response from the Document Server.
          # @param error The error that occurred when sending the request.
          sig do
            params(
              request: Net::HTTPRequest,
              response: Net::HTTPResponse,
              error: T.nilable(Object),
            ).void
          end
          def initialize(request:, response:, error: nil)
            @request = request
            @response = response
            @error = error
          end
        end
      end
    end
  end
end
