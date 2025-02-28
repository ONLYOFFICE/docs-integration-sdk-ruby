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
require_relative "response"
require_relative "service"

module Onlyoffice
  module DocsIntegrationSdk
    module DocumentServer
      class Client
        # CommandServing is an interface that describes the methods that must be
        # implemented to be considered a command service.
        #
        # @since 0.1.0
        module CommandServing
          extend T::Sig
          extend T::Helpers
          interface!

          # @param r The request options.
          # @return A tuple containing the result and the response.
          # @since 0.1.0
          sig {abstract.params(r: CommandService::Request).returns([CommandService::Result, Response])}
          def do(r); end
        end

        # CommandService is an implementation of the {CommandServing} interface.
        #
        # @since 0.1.0
        class CommandService < Service
          include CommandServing

          # Error is an enum that represents the possible errors that can occur
          # when using the command service.
          #
          # @since 0.1.0
          class Error < T::Enum
            extend T::Sig

            enums do
              # @since 0.1.0
              None = new(0)

              # @since 0.1.0
              MissingDocumentKey = new(1)

              # @since 0.1.0
              IncorrectCallbackUrl = new(2)

              # @since 0.1.0
              InternalError = new(3)

              # @since 0.1.0
              NoChanges = new(4)

              # @since 0.1.0
              IncorrectCommand = new(5)

              # @since 0.1.0
              InvalidToken = new(6)
            end

            # description returns the human-readable description of the error.
            #
            # @since 0.1.0
            sig {returns(String)}
            def description
              case self
              when None
                "No errors"
              when MissingDocumentKey
                "Document key is missing or no document with such key could be found"
              when IncorrectCallbackUrl
                "Callback url not correct"
              when InternalError
                "Internal server error"
              when NoChanges
                "No changes were applied to the document before the forcesave command was received"
              when IncorrectCommand
                "Command not correct"
              when InvalidToken
                "Invalid token"
              else
                # :nocov:
                # unreachable
                # :nocov:
              end
            end
          end

          # Request is a class that represents the request options for the
          # command service.
          #
          # @since 0.1.0
          class Request < T::Struct
            extend T::Sig

            # @since 0.1.0
            class C < T::Enum
              enums do
                # @since 0.1.0
                DeleteForgotten = new("deleteForgotten")

                # @since 0.1.0
                Drop = new("drop")

                # @since 0.1.0
                Forcesave = new("forcesave")

                # @since 0.1.0
                GetForgotten = new("getForgotten")

                # @since 0.1.0
                GetForgottenList = new("getForgottenList")

                # @since 0.1.0
                Info = new("info")

                # @since 0.1.0
                License = new("license")

                # @since 0.1.0
                Meta = new("meta")

                # @since 0.1.0
                Version = new("version")
              end
            end

            # @since 0.1.0
            class License < T::Struct
              extend T::Sig

              # @since 0.1.0
              prop :end_date, T.nilable(String), name: "end_date"

              # @since 0.1.0
              prop :trial, T.nilable(T::Boolean), name: "trial"

              # @since 0.1.0
              prop :customization, T.nilable(T::Boolean), name: "customization"

              # @since 0.1.0
              prop :connections, T.nilable(Integer), name: "connections"

              # @since 0.1.0
              prop :connections_view, T.nilable(Integer), name: "connections_view"

              # @since 0.1.0
              prop :users_count, T.nilable(Integer), name: "users_count"

              # @since 0.1.0
              prop :users_view_count, T.nilable(Integer), name: "users_view_count"

              # @since 0.1.0
              prop :users_expire, T.nilable(Integer), name: "users_expire"

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(License)}
              def self.from_hash(hash, strict = nil)
                super(hash, strict)
              end
            end

            # @since 0.1.0
            class Server < T::Struct
              extend T::Sig

              # @since 0.1.0
              class ResultType < T::Enum
                extend T::Sig

                enums do
                  # @since 0.1.0
                  Error = new(1)

                  # @since 0.1.0
                  LicenseExpired = new(2)

                  # @since 0.1.0
                  LicenseAvailable = new(3)

                  # @since 0.1.0
                  TrialLicenseExpired = new(6)
                end

                # description returns the human-readable description of the
                # result type.
                #
                # @since 0.1.0
                sig {returns(String)}
                def description
                  case self
                  when Error
                    "An error occurred"
                  when LicenseExpired
                    "The license expired"
                  when LicenseAvailable
                    "The license is still available"
                  when TrialLicenseExpired
                    "The trial license expired"
                  else
                    # :nocov:
                    # unreachable
                    # :nocov:
                  end
                end
              end

              # @since 0.1.0
              class PackageType < T::Enum
                enums do
                  # @since 0.1.0
                  OpenSource = new(0)

                  # @since 0.1.0
                  Enterprise = new(1)

                  # @since 0.1.0
                  Developer = new(2)
                end
              end

              # @since 0.1.0
              prop :result_type, T.nilable(ResultType), name: "resultType"

              # @since 0.1.0
              prop :package_type, T.nilable(PackageType), name: "packageType"

              # @since 0.1.0
              prop :build_date, T.nilable(String), name: "buildDate"

              # @since 0.1.0
              prop :build_version, T.nilable(String), name: "buildVersion"

              # @since 0.1.0
              prop :build_number, T.nilable(Integer), name: "buildNumber"

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(Server)}
              def self.from_hash(hash, strict = nil)
                super(hash, strict)
              end
            end

            # @since 0.1.0
            class Quota < T::Struct
              extend T::Sig

              # @since 0.1.0
              class User < T::Struct
                extend T::Sig

                # @since 0.1.0
                prop :userid, T.nilable(String), name: "userid"

                # @since 0.1.0
                prop :expire, T.nilable(String), name: "expire"

                # @since 0.1.0
                sig {params(hash: T.untyped, strict: T.untyped).returns(User)}
                def self.from_hash(hash, strict = nil)
                  super(hash, strict)
                end
              end

              # @since 0.1.0
              prop :users, T.nilable(T::Array[User]), name: "users"

              # @since 0.1.0
              prop :users_view, T.nilable(T::Array[User]), name: "users_view"

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(Quota)}
              def self.from_hash(hash, strict = nil)
                super(hash, strict)
              end
            end

            # @since 0.1.0
            class Meta < T::Struct
              extend T::Sig

              # @since 0.1.0
              prop :title, T.nilable(String), name: "title"

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(Meta)}
              def self.from_hash(hash, strict = nil)
                super(hash, strict)
              end
            end

            # @since 0.1.0
            prop :c, T.nilable(C), name: "c"

            # @since 0.1.0
            prop :key, T.nilable(String), name: "key"

            # @since 0.1.0
            prop :users, T.nilable(T::Array[String]), name: "users"

            # @since 0.1.0
            prop :userdata, T.nilable(String), name: "userdata"

            # @since 0.1.0
            prop :license, T.nilable(License), name: "license"

            # @since 0.1.0
            prop :server, T.nilable(Server), name: "server"

            # @since 0.1.0
            prop :quota, T.nilable(Quota), name: "quota"

            # @since 0.1.0
            prop :meta, T.nilable(Meta), name: "meta"

            # @since 0.1.0
            sig {params(hash: T.untyped, strict: T.untyped).returns(Request)}
            def self.from_hash(hash, strict = nil)
              super(hash, strict)
            end
          end

          # Result is a class that represents the result of the command service
          # call.
          #
          # @since 0.1.0
          class Result < T::Struct
            extend T::Sig

            # @since 0.1.0
            prop :key, T.nilable(String), name: "key"

            # @since 0.1.0
            prop :url, T.nilable(String), name: "url"

            # @since 0.1.0
            prop :keys, T.nilable(T::Array[String]), name: "keys"

            # @since 0.1.0
            prop :users, T.nilable(T::Array[String]), name: "users"

            # @since 0.1.0
            prop :version, T.nilable(String), name: "version"

            # @since 0.1.0
            sig {params(hash: T.untyped, strict: T.untyped).returns(Result)}
            def self.from_hash(hash, strict = nil)
              super(hash, strict)
            end
          end

          # do makes a request to the command service. It returns an empty
          # result if an error occurs.
          #
          # @param r The request options.
          # @return A tuple containing the result and the response.
          # @since 0.1.0
          sig {override.params(r: Request).returns([Result, Response])}
          def do(r)
            com, res = @client.post("coauthoring/CommandService.ashx", r.serialize)
            if res.error
              return [Result.new, res]
            end

            err = T.let(nil, T.untyped)

            begin
              if com && com.is_a?(Hash) && com.key?("error")
                err = Error.from_serialized(com["error"])
                if err == Error::None
                  err = nil
                  ret = Result.from_hash(com)
                end
              elsif com
                ret = Result.from_hash(com)
              else
                ret = Result.new
              end
            rescue StandardError => e
              err = e
            end

            if err
              ret = Result.new
              res = Response.new(
                request: res.request,
                response: res.response,
                error: err,
              )
            end

            [ret, res]
          end
        end
      end
    end
  end
end
