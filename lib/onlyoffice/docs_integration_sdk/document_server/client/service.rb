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

module Onlyoffice
  module DocsIntegrationSdk
    module DocumentServer
      class Client
        # Service is a base class for all services.
        #
        # @since 0.1.0
        class Service
          extend T::Sig
          extend T::Helpers
          abstract!

          # @param client The client instance.
          # @since 0.1.0
          sig {overridable.params(client: Client).void}
          def initialize(client:)
            @client = client
          end
        end
      end
    end
  end
end
