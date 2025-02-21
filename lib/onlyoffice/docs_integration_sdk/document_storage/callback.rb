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
    module DocumentStorage
      # @since 0.1.0
      module Callback
        # @since 0.1.0
        class Request < T::Struct
          extend T::Sig

          # @since 0.1.0
          class Action < T::Struct
            extend T::Sig

            # @since 0.1.0
            class Type < T::Enum
              extend T::Sig

              enums do
                # @since 0.1.0
                Disconnect = new(0)

                # @since 0.1.0
                Connect = new(1)

                # @since 0.1.0
                ForceSave = new(2)
              end

              # description returns the human-readable description of the type.
              #
              # @since 0.1.0
              sig {returns(String)}
              def description
                case self
                when Disconnect
                  "The user disconnects from the document co-editing"
                when Connect
                  "The new user connects to the document co-editing"
                when ForceSave
                  "The user clicks the forcesave button"
                else
                  # :nocov:
                  # unreachable
                  # :nocov:
                end
              end
            end

            # @since 0.1.0
            prop :type, T.nilable(Type), name: "type"

            # @since 0.1.0
            prop :user_id, T.nilable(String), name: "userid"

            # @since 0.1.0
            sig {params(hash: T.untyped, strict: T.untyped).returns(Action)}
            def self.from_hash(hash, strict = nil)
              super(hash, strict)
            end
          end

          # @since 0.1.0
          class ForceSaveType < T::Enum
            enums do
              # @since 0.1.0
              Command = new(0)

              # @since 0.1.0
              Save = new(1)

              # @since 0.1.0
              Time = new(2)

              # @since 0.1.0
              Submit = new(3)
            end
          end

          # @since 0.1.0
          class FormData < T::Struct
            extend T::Sig

            # @since 0.1.0
            class Type < T::Enum
              enums do
                # @since 0.1.0
                Text = new("text")

                # @since 0.1.0
                CheckBox = new("checkBox")

                # @since 0.1.0
                Picture = new("picture")

                # @since 0.1.0
                ComboBox = new("comboBox")

                # @since 0.1.0
                DropDownList = new("dropDownList")

                # @since 0.1.0
                DateTime = new("dateTime")

                # @since 0.1.0
                Radio = new("radio")
              end
            end

            # @since 0.1.0
            prop :key, T.nilable(String), name: "key"

            # @since 0.1.0
            prop :tag, T.nilable(String), name: "tag"

            # @since 0.1.0
            prop :value, T.nilable(String), name: "value"

            # @since 0.1.0
            prop :type, T.nilable(Type), name: "type"

            # @since 0.1.0
            sig {params(hash: T.untyped, strict: T.untyped).returns(FormData)}
            def self.from_hash(hash, strict = nil)
              super(hash, strict)
            end
          end

          # @since 0.1.0
          class History < T::Struct
            extend T::Sig

            # @since 0.1.0
            prop :changes, T.nilable(T::Hash[T.untyped, T.untyped]), name: "changes"

            # @since 0.1.0
            prop :server_version, T.nilable(String), name: "serverVersion"

            # @since 0.1.0
            sig {params(hash: T.untyped, strict: T.untyped).returns(History)}
            def self.from_hash(hash, strict = nil)
              super(hash, strict)
            end
          end

          # @since 0.1.0
          class Status < T::Enum
            extend T::Sig

            enums do
              # @since 0.1.0
              Editing = new(1)

              # @since 0.1.0
              Save = new(2)

              # @since 0.1.0
              SaveError = new(3)

              # @since 0.1.0
              Closed = new(4)

              # @since 0.1.0
              ForceSave = new(6)

              # @since 0.1.0
              ForceSaveError = new(7)
            end

            # description returns the human-readable description of the status.
            #
            # @since 0.1.0
            sig {returns(String)}
            def description
              case self
              when Editing
                "The document is being edited"
              when Save
                "The document is ready to be saved"
              when SaveError
                "An error occurred while saving the document"
              when Closed
                "The document was closed without changes"
              when ForceSave
                "Editing of the document continues, but the current state of the document is saved"
              when ForceSaveError
                "An error occurred while forcing the document to be saved"
              else
                # :nocov:
                # unreachable
                # :nocov:
              end
            end
          end

          # @since 0.1.0
          prop :actions, T.nilable(T::Array[Action]), name: "actions"

          # @deprecated Use {history} instead. This property is deprecated since Document Server version 4.2.
          # @since 0.1.0
          prop :changeshistory, T.nilable(T::Array[T.untyped]), name: "changeshistory"

          # @since 0.1.0
          prop :changesurl, T.nilable(String), name: "changesurl"

          # @since 0.1.0
          prop :filetype, T.nilable(String), name: "filetype"

          # @since 0.1.0
          prop :forcesavetype, T.nilable(ForceSaveType), name: "forcesavetype"

          # @since 0.1.0
          prop :formsdataurl, T.nilable(String), name: "formsdataurl"

          # @since 0.1.0
          prop :history, T.nilable(History), name: "history"

          # @since 0.1.0
          prop :key, T.nilable(String), name: "key"

          # @since 0.1.0
          prop :status, T.nilable(Status), name: "status"

          # @since 0.1.0
          prop :url, T.nilable(String), name: "url"

          # @since 0.1.0
          prop :userdata, T.nilable(String), name: "userdata"

          # @since 0.1.0
          prop :users, T.nilable(T::Array[String]), name: "users"

          # @since 0.1.0
          sig {params(hash: T.untyped, strict: T.untyped).returns(Request)}
          def self.from_hash(hash, strict = nil)
            super(hash, strict)
          end
        end

        # @since 0.1.0
        class Response < T::Struct
          extend T::Sig

          # @since 0.1.0
          prop :error, Integer, name: "error"

          # @since 0.1.0
          sig {params(hash: T.untyped, strict: T.untyped).returns(Response)}
          def self.from_hash(hash, strict = nil)
            super(hash, strict)
          end
        end
      end
    end
  end
end
