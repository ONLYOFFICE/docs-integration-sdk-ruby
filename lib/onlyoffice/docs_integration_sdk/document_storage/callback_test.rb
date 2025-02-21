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
require_relative "../test_test"
require_relative "callback"

module Onlyoffice
  module DocsIntegrationSdk
    module DocumentStorage
      module Callback
        class Request
          class Action
            class TypeTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::DescriptiveEnumMarshalling

              sig {override.returns(T::Array[[Integer, String, Type]])}
              def cases
                [
                  [
                    0,
                    "The user disconnects from the document co-editing",
                    Type::Disconnect,
                  ],
                  [
                    1,
                    "The new user connects to the document co-editing",
                    Type::Connect,
                  ],
                  [
                    2,
                    "The user clicks the forcesave button",
                    Type::ForceSave,
                  ],
                ]
              end
            end
          end

          class ActionTest < ::Test::Unit::TestCase
            extend T::Sig
            include Test::StructMarshalling

            sig {override.returns(T::Array[[T.untyped, Action]])}
            def cases
              [
                [
                  {},
                  Action.new,
                ],
                [
                  {
                    "type" => 0,
                    "userid" => "user",
                  },
                  Action.new(
                    type: Action::Type::Disconnect,
                    user_id: "user",
                  ),
                ],
              ]
            end
          end

          class ForceSaveTypeTest < ::Test::Unit::TestCase
            extend T::Sig
            include Test::BasicEnumMarshalling

            sig {override.returns(T::Array[[Integer, ForceSaveType]])}
            def cases
              [
                [0, ForceSaveType::Command],
                [1, ForceSaveType::Save],
                [2, ForceSaveType::Time],
                [3, ForceSaveType::Submit],
              ]
            end
          end

          class FormData
            class TypeTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::BasicEnumMarshalling

              sig {override.returns(T::Array[[String, Type]])}
              def cases
                [
                  ["text", Type::Text],
                  ["checkBox", Type::CheckBox],
                  ["picture", Type::Picture],
                  ["comboBox", Type::ComboBox],
                  ["dropDownList", Type::DropDownList],
                  ["dateTime", Type::DateTime],
                  ["radio", Type::Radio],
                ]
              end
            end
          end

          class FormDataTest < ::Test::Unit::TestCase
            extend T::Sig
            include Test::StructMarshalling

            sig {override.returns(T::Array[[T.untyped, FormData]])}
            def cases
              [
                [
                  {},
                  FormData.new,
                ],
                [
                  {
                    "key" => "text_1",
                    "tag" => "label",
                    "value" => "hello",
                    "type" => "text",
                  },
                  FormData.new(
                    key: "text_1",
                    tag: "label",
                    value: "hello",
                    type: FormData::Type::Text,
                  ),
                ],
              ]
            end
          end

          class HistoryTest < ::Test::Unit::TestCase
            extend T::Sig
            include Test::StructMarshalling

            sig {override.returns(T::Array[[T.untyped, History]])}
            def cases
              [
                [
                  {},
                  History.new,
                ],
                [
                  {
                    "changes" => {},
                    "serverVersion" => "1.0",
                  },
                  History.new(
                    changes: {},
                    server_version: "1.0",
                  ),
                ],
              ]
            end
          end

          class StatusTest < ::Test::Unit::TestCase
            extend T::Sig
            include Test::DescriptiveEnumMarshalling

            sig {override.returns(T::Array[[Integer, String, Status]])}
            def cases
              [
                [
                  1,
                  "The document is being edited",
                  Status::Editing,
                ],
                [
                  2,
                  "The document is ready to be saved",
                  Status::Save,
                ],
                [
                  3,
                  "An error occurred while saving the document",
                  Status::SaveError,
                ],
                [
                  4,
                  "The document was closed without changes",
                  Status::Closed,
                ],
                [
                  6,
                  "Editing of the document continues, but the current state of the document is saved",
                  Status::ForceSave,
                ],
                [
                  7,
                  "An error occurred while forcing the document to be saved",
                  Status::ForceSaveError,
                ],
              ]
            end
          end
        end

        class RequestTest < ::Test::Unit::TestCase
          extend T::Sig
          include Test::StructMarshalling

          sig {override.returns(T::Array[[T.untyped, Request]])}
          def cases
            [
              [
                {},
                Request.new,
              ],
              [
                {
                  "actions" => [
                    {
                      "type" => 0,
                    },
                  ],
                  "changeshistory" => [],
                  "changesurl" => "http://localhost:8080/",
                  "filetype" => "pdf",
                  "forcesavetype" => 0,
                  "formsdataurl" => "http://localhost:8080/",
                  "history" => {
                    "changes" => {},
                  },
                  "key" => "***",
                  "status" => 1,
                  "url" => "http://localhost:8080/",
                  "userdata" => "data",
                  "users" => ["user_1"],
                },
                Request.new(
                  actions: [
                    Request::Action.new(
                      type: Request::Action::Type::Disconnect,
                    ),
                  ],
                  changeshistory: [],
                  changesurl: "http://localhost:8080/",
                  filetype: "pdf",
                  forcesavetype: Request::ForceSaveType::Command,
                  formsdataurl: "http://localhost:8080/",
                  history: Request::History.new(
                    changes: {},
                  ),
                  key: "***",
                  status: Request::Status::Editing,
                  url: "http://localhost:8080/",
                  userdata: "data",
                  users: ["user_1"],
                ),
              ],
            ]
          end
        end

        class ResponseTest < ::Test::Unit::TestCase
          extend T::Sig
          include Test::StructMarshalling

          sig {override.returns(T::Array[[T.untyped, Response]])}
          def cases
            [
              [
                {
                  "error" => 0,
                },
                Response.new(
                  error: 0,
                ),
              ],
            ]
          end
        end
      end
    end
  end
end
