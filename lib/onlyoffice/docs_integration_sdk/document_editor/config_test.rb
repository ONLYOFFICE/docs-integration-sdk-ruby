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

require "test/unit"
require_relative "../test_test"
require_relative "config"

module Onlyoffice
  module DocsIntegrationSdk
    module DocumentEditor
      class Config
        class DocumentTypeTest < ::Test::Unit::TestCase
          extend T::Sig
          include Test::BasicEnumMarshalling

          sig {override.returns(T::Array[[String, DocumentType]])}
          def cases
            [
              ["word", DocumentType::Word],
              ["cell", DocumentType::Cell],
              ["slide", DocumentType::Slide],
              ["pdf", DocumentType::Pdf],
              ["text", DocumentType::Text],
              ["spreadsheet", DocumentType::Spreadsheet],
              ["presentation", DocumentType::Presentation],
            ]
          end
        end

        class TypeTest < ::Test::Unit::TestCase
          extend T::Sig
          include Test::BasicEnumMarshalling

          sig {override.returns(T::Array[[String, Type]])}
          def cases
            [
              ["desktop", Type::Desktop],
              ["mobile", Type::Mobile],
              ["embedded", Type::Embedded],
            ]
          end
        end

        class Document
          class ReferenceDataTest < ::Test::Unit::TestCase
            extend T::Sig
            include Test::StructMarshalling

            sig {override.returns(T::Array[[T.untyped, ReferenceData]])}
            def cases
              [
                [
                  {},
                  ReferenceData.new,
                ],
                [
                  {
                    "fileKey" => "***",
                    "instanceId" => "42",
                    "key" => "***",
                  },
                  ReferenceData.new(
                    file_key: "***",
                    instance_id: "42",
                    key: "***",
                  ),
                ],
              ]
            end
          end

          class Info
            class SharingSettings
              class PermissionsTest < ::Test::Unit::TestCase
                extend T::Sig
                include Test::BasicEnumMarshalling

                sig {override.returns(T::Array[[String, Permissions]])}
                def cases
                  [
                    ["Full Access", Permissions::FullAccess],
                    ["Read Only", Permissions::ReadOnly],
                    ["Deny Access", Permissions::DenyAccess],
                  ]
                end
              end
            end

            class SharingSettingsTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::StructMarshalling

              sig {override.returns(T::Array[[T.untyped, SharingSettings]])}
              def cases
                [
                  [
                    {},
                    SharingSettings.new,
                  ],
                  [
                    {
                      "isLink" => true,
                      "permissions" => "Full Access",
                      "user" => "user_1",
                    },
                    SharingSettings.new(
                      is_link: true,
                      permissions: SharingSettings::Permissions::FullAccess,
                      user: "user_1",
                    )
                  ],
                ]
              end
            end
          end

          class InfoTest < ::Test::Unit::TestCase
            extend T::Sig
            include Test::StructMarshalling

            sig {override.returns(T::Array[[T.untyped, Info]])}
            def cases
              [
                [
                  {},
                  Info.new,
                ],
                [
                  {
                    "author" => "author_1",
                    "created" => "2025-01-01T00:00:00Z",
                    "favorite" => true,
                    "folder" => "folder_1",
                    "owner" => "owner_1",
                    "sharingSettings" => [
                      {
                        "isLink" => true,
                      },
                    ],
                    "uploaded" => "2025-01-01T00:00:00Z",
                  },
                  Info.new(
                    author: "author_1",
                    created: "2025-01-01T00:00:00Z",
                    favorite: true,
                    folder: "folder_1",
                    owner: "owner_1",
                    sharing_settings: [
                      Info::SharingSettings.new(
                        is_link: true,
                      ),
                    ],
                    uploaded: "2025-01-01T00:00:00Z",
                  ),
                ],
              ]
            end
          end

          class Permissions
            class CommentGroupTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::StructMarshalling

              sig {override.returns(T::Array[[T.untyped, CommentGroup]])}
              def cases
                [
                  [
                    {},
                    CommentGroup.new,
                  ],
                  [
                    {
                      "edit" => ["group_1"],
                      "remove" => ["group_1"],
                      "view" => ["group_1"],
                    },
                    CommentGroup.new(
                      edit: ["group_1"],
                      remove: ["group_1"],
                      view: ["group_1"],
                    ),
                  ],
                ]
              end
            end
          end

          class PermissionsTest < ::Test::Unit::TestCase
            extend T::Sig
            include Test::StructMarshalling

            sig {override.returns(T::Array[[T.untyped, Permissions]])}
            def cases
              [
                [
                  {},
                  Permissions.new,
                ],
                [
                  {
                    "changeHistory" => true,
                    "chat" => true,
                    "comment" => true,
                    "commentGroups" => [
                      {
                        "edit" => ["group_1"],
                      },
                    ],
                    "copy" => true,
                    "deleteCommentAuthorOnly" => true,
                    "download" => true,
                    "edit" => true,
                    "editCommentAuthorOnly" => true,
                    "fillForms" => true,
                    "modifyContentControl" => true,
                    "modifyFilter" => true,
                    "print" => true,
                    "protect" => true,
                    "rename" => true,
                    "review" => true,
                    "reviewGroups" => ["group_1"],
                    "userInfoGroups" => ["group_1"],
                  },
                  Permissions.new(
                    change_history: true,
                    chat: true,
                    comment: true,
                    comment_groups: [
                      Permissions::CommentGroup.new(
                        edit: ["group_1"],
                      ),
                    ],
                    copy: true,
                    delete_comment_author_only: true,
                    download: true,
                    edit: true,
                    edit_comment_author_only: true,
                    fill_forms: true,
                    modify_content_control: true,
                    modify_filter: true,
                    print: true,
                    protect: true,
                    rename: true,
                    review: true,
                    review_groups: ["group_1"],
                    user_info_groups: ["group_1"],
                  ),
                ],
              ]
            end
          end
        end

        class DocumentTest < ::Test::Unit::TestCase
          extend T::Sig
          include Test::StructMarshalling

          sig {override.returns(T::Array[[T.untyped, Document]])}
          def cases
            [
              [
                {},
                Document.new,
              ],
              [
                {
                  "fileType" => "docx",
                  "key" => "***",
                  "referenceData" => {
                    "fileKey" => "***",
                  },
                  "title" => "Document",
                  "url" => "http://localhost:8080/",
                  "info" => {
                    "author" => "author_1",
                  },
                  "permissions" => {
                    "changeHistory" => true,
                  },
                },
                Document.new(
                  file_type: "docx",
                  key: "***",
                  reference_data: Document::ReferenceData.new(
                    file_key: "***",
                  ),
                  title: "Document",
                  url: "http://localhost:8080/",
                  info: Document::Info.new(
                    author: "author_1",
                  ),
                  permissions: Document::Permissions.new(
                    change_history: true,
                  ),
                ),
              ],
            ]
          end
        end

        class EditorConfig
          class CoEditing
            class ModeTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::BasicEnumMarshalling

              sig {override.returns(T::Array[[String, Mode]])}
              def cases
                [
                  ["fast", Mode::Fast],
                  ["strict", Mode::Strict],
                ]
              end
            end
          end

          class CoEditingTest < ::Test::Unit::TestCase
            extend T::Sig
            include Test::StructMarshalling

            sig {override.returns(T::Array[[T.untyped, CoEditing]])}
            def cases
              [
                [
                  {},
                  CoEditing.new,
                ],
                [
                  {
                    "mode" => "fast",
                    "change" => true,
                  },
                  CoEditing.new(
                    mode: CoEditing::Mode::Fast,
                    change: true,
                  ),
                ],
              ]
            end
          end

          class ModeTest < ::Test::Unit::TestCase
            extend T::Sig
            include Test::BasicEnumMarshalling

            sig {override.returns(T::Array[[String, Mode]])}
            def cases
              [
                ["view", Mode::View],
                ["edit", Mode::Edit],
              ]
            end
          end

          class RecentTest < ::Test::Unit::TestCase
            extend T::Sig
            include Test::StructMarshalling

            sig {override.returns(T::Array[[T.untyped, Recent]])}
            def cases
              [
                [
                  {},
                  Recent.new,
                ],
                [
                  {
                    "folder" => "folder_1",
                    "title" => "Document",
                    "url" => "http://localhost:8080/",
                  },
                  Recent.new(
                    folder: "folder_1",
                    title: "Document",
                    url: "http://localhost:8080/",
                  ),
                ],
              ]
            end
          end

          class TemplateTest < ::Test::Unit::TestCase
            extend T::Sig
            include Test::StructMarshalling

            sig {override.returns(T::Array[[T.untyped, Template]])}
            def cases
              [
                [
                  {},
                  Template.new,
                ],
                [
                  {
                    "image" => "http://localhost:8080/",
                    "title" => "Document",
                    "url" => "http://localhost:8080/",
                  },
                  Template.new(
                    image: "http://localhost:8080/",
                    title: "Document",
                    url: "http://localhost:8080/",
                  ),
                ],
              ]
            end
          end

          class UserTest < ::Test::Unit::TestCase
            extend T::Sig
            include Test::StructMarshalling

            sig {override.returns(T::Array[[T.untyped, User]])}
            def cases
              [
                [
                  {},
                  User.new,
                ],
                [
                  {
                    "firstname" => "First",
                    "group" => "group_1",
                    "id" => "42",
                    "image" => "http://localhost:8080/",
                    "lastname" => "Last",
                    "name" => "First Last",
                  },
                  User.new(
                    firstname: "First",
                    group: "group_1",
                    id: "42",
                    image: "http://localhost:8080/",
                    lastname: "Last",
                    name: "First Last",
                  ),
                ],
              ]
            end
          end

          class Customization
            class AnonymousTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::StructMarshalling

              sig {override.returns(T::Array[[T.untyped, Anonymous]])}
              def cases
                [
                  [
                    {},
                    Anonymous.new,
                  ],
                  [
                    {
                      "request" => true,
                      "label" => "Anonymous",
                    },
                    Anonymous.new(
                      request: true,
                      label: "Anonymous",
                    ),
                  ],
                ]
              end
            end

            class CloseTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::StructMarshalling

              sig {override.returns(T::Array[[T.untyped, Close]])}
              def cases
                [
                  [
                    {},
                    Close.new,
                  ],
                  [
                    {
                      "visible" => true,
                      "text" => "Close",
                    },
                    Close.new(
                      visible: true,
                      text: "Close",
                    ),
                  ],
                ]
              end
            end

            class CustomerTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::StructMarshalling

              sig {override.returns(T::Array[[T.untyped, Customer]])}
              def cases
                [
                  [
                    {},
                    Customer.new,
                  ],
                  [
                    {
                      "address" => "Address",
                      "info" => "Info",
                      "logo" => "http://localhost:8080/",
                      "logoDark" => "http://localhost:8080/",
                      "mail" => "mail@localhost",
                      "name" => "Customer",
                      "phone" => "1234567890",
                      "www" => "http://localhost:8080/",
                    },
                    Customer.new(
                      address: "Address",
                      info: "Info",
                      logo: "http://localhost:8080/",
                      logo_dark: "http://localhost:8080/",
                      mail: "mail@localhost",
                      name: "Customer",
                      phone: "1234567890",
                      www: "http://localhost:8080/",
                    ),
                  ],
                ]
              end
            end

            class Features
              class SpellcheckTest < ::Test::Unit::TestCase
                extend T::Sig
                include Test::StructMarshalling

                sig {override.returns(T::Array[[T.untyped, Spellcheck]])}
                def cases
                  [
                    [
                      {},
                      Spellcheck.new,
                    ],
                    [
                      {
                        "mode" => true,
                        "change" => true,
                      },
                      Spellcheck.new(
                        mode: true,
                        change: true,
                      ),
                    ],
                  ]
                end
              end

              class TabBackground
                class ModeTest < ::Test::Unit::TestCase
                  extend T::Sig
                  include Test::BasicEnumMarshalling

                  sig {override.returns(T::Array[[String, Mode]])}
                  def cases
                    [
                      ["header", Mode::Header],
                      ["toolbar", Mode::Toolbar],
                    ]
                  end
                end
              end

              class TabBackgroundTest < ::Test::Unit::TestCase
                extend T::Sig
                include Test::StructMarshalling

                sig {override.returns(T::Array[[T.untyped, TabBackground]])}
                def cases
                  [
                    [
                      {},
                      TabBackground.new,
                    ],
                    [
                      {
                        "mode" => "header",
                        "change" => true,
                      },
                      TabBackground.new(
                        mode: TabBackground::Mode::Header,
                        change: true,
                      ),
                    ],
                  ]
                end
              end

              class TabStyle
                class ModeTest < ::Test::Unit::TestCase
                  extend T::Sig
                  include Test::BasicEnumMarshalling

                  sig {override.returns(T::Array[[String, Mode]])}
                  def cases
                    [
                      ["fill", Mode::Fill],
                      ["line", Mode::Line],
                    ]
                  end
                end
              end

              class TabStyleTest < ::Test::Unit::TestCase
                extend T::Sig
                include Test::StructMarshalling

                sig {override.returns(T::Array[[T.untyped, TabStyle]])}
                def cases
                  [
                    [
                      {},
                      TabStyle.new,
                    ],
                    [
                      {
                        "mode" => "fill",
                        "change" => true,
                      },
                      TabStyle.new(
                        mode: TabStyle::Mode::Fill,
                        change: true,
                      ),
                    ],
                  ]
                end
              end
            end

            class FeaturesTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::StructMarshalling

              sig {override.returns(T::Array[[T.untyped, Features]])}
              def cases
                [
                  [
                    {},
                    Features.new,
                  ],
                  [
                    {
                      "roles" => true,
                      "spellcheck" => true,
                      "tabBackground" => "header",
                      "tabStyle" => "fill",
                    },
                    Features.new(
                      roles: true,
                      spellcheck: true,
                      tab_background: Features::TabBackground::Mode::Header,
                      tab_style: Features::TabStyle::Mode::Fill,
                    ),
                  ],
                  [
                    {
                      "spellcheck" => {
                        "mode" => true,
                      },
                      "tabBackground" => {
                        "mode" => "header",
                      },
                      "tabStyle" => {
                        "mode" => "fill",
                      },
                    },
                    Features.new(
                      spellcheck: Features::Spellcheck.new(
                        mode: true,
                      ),
                      tab_background: Features::TabBackground.new(
                        mode: Features::TabBackground::Mode::Header,
                      ),
                      tab_style: Features::TabStyle.new(
                        mode: Features::TabStyle::Mode::Fill,
                      ),
                    ),
                  ],
                ]
              end
            end

            class FeedbackTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::StructMarshalling

              sig {override.returns(T::Array[[T.untyped, Feedback]])}
              def cases
                [
                  [
                    {},
                    Feedback.new,
                  ],
                  [
                    {
                      "url" => "http://localhost:8080/",
                      "visible" => true,
                    },
                    Feedback.new(
                      url: "http://localhost:8080/",
                      visible: true,
                    ),
                  ],
                ]
              end
            end

            class FontTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::StructMarshalling

              sig {override.returns(T::Array[[T.untyped, Font]])}
              def cases
                [
                  [
                    {},
                    Font.new,
                  ],
                  [
                    {
                      "name" => "Arial",
                      "size" => "12px",
                    },
                    Font.new(
                      name: "Arial",
                      size: "12px",
                    ),
                  ],
                ]
              end
            end

            class GoBackTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::StructMarshalling

              sig {override.returns(T::Array[[T.untyped, GoBack]])}
              def cases
                [
                  [
                    {},
                    GoBack.new,
                  ],
                  [
                    {
                      "blank" => true,
                      "requestClose" => true,
                      "text" => "Go Back",
                      "url" => "http://localhost:8080/",
                    },
                    GoBack.new(
                      blank: true,
                      request_close: true,
                      text: "Go Back",
                      url: "http://localhost:8080/",
                    ),
                  ],
                ]
              end
            end

            class IntegrationModeTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::BasicEnumMarshalling

              sig {override.returns(T::Array[[String, IntegrationMode]])}
              def cases
                [
                  ["embed", IntegrationMode::Embed],
                ]
              end
            end

            class Layout
              class HeaderTest < ::Test::Unit::TestCase
                extend T::Sig
                include Test::StructMarshalling

                sig {override.returns(T::Array[[T.untyped, Header]])}
                def cases
                  [
                    [
                      {},
                      Header.new,
                    ],
                    [
                      {
                        "editMode" => true,
                        "save" => true,
                        "users" => true,
                      },
                      Header.new(
                        edit_mode: true,
                        save: true,
                        users: true,
                      ),
                    ],
                  ]
                end
              end

              class LeftMenuTest < ::Test::Unit::TestCase
                extend T::Sig
                include Test::StructMarshalling

                sig {override.returns(T::Array[[T.untyped, LeftMenu]])}
                def cases
                  [
                    [
                      {},
                      LeftMenu.new,
                    ],
                    [
                      {
                        "menu" => true,
                        "navigation" => true,
                        "spellcheck" => true,
                      },
                      LeftMenu.new(
                        menu: true,
                        navigation: true,
                        spellcheck: true,
                      ),
                    ],
                  ]
                end
              end

              class RightMenuTest < ::Test::Unit::TestCase
                extend T::Sig
                include Test::StructMarshalling

                sig {override.returns(T::Array[[T.untyped, RightMenu]])}
                def cases
                  [
                    [
                      {},
                      RightMenu.new,
                    ],
                    [
                      {
                        "mode" => true,
                      },
                      RightMenu.new(
                        mode: true,
                      ),
                    ],
                  ]
                end
              end

              class StatusBarTest < ::Test::Unit::TestCase
                extend T::Sig
                include Test::StructMarshalling

                sig {override.returns(T::Array[[T.untyped, StatusBar]])}
                def cases
                  [
                    [
                      {},
                      StatusBar.new,
                    ],
                    [
                      {
                        "actionStatus" => true,
                        "docLang" => true,
                        "textLang" => true,
                      },
                      StatusBar.new(
                        action_status: true,
                        doc_lang: true,
                        text_lang: true,
                      ),
                    ],
                  ]
                end
              end

              class Toolbar
                class CollaborationTest < ::Test::Unit::TestCase
                  extend T::Sig
                  include Test::StructMarshalling

                  sig {override.returns(T::Array[[T.untyped, Collaboration]])}
                  def cases
                    [
                      [
                        {},
                        Collaboration.new,
                      ],
                      [
                        {
                          "mailmerge" => true,
                        },
                        Collaboration.new(
                          mailmerge: true,
                        ),
                      ],
                    ]
                  end
                end

                class FileTest < ::Test::Unit::TestCase
                  extend T::Sig
                  include Test::StructMarshalling

                  sig {override.returns(T::Array[[T.untyped, File]])}
                  def cases
                    [
                      [
                        {},
                        File.new,
                      ],
                      [
                        {
                          "close" => true,
                          "info" => true,
                          "save" => true,
                          "settings" => true,
                        },
                        File.new(
                          close: true,
                          info: true,
                          save: true,
                          settings: true,
                        ),
                      ],
                    ]
                  end
                end

                class HomeTest < ::Test::Unit::TestCase
                  extend T::Sig
                  include Test::StructMarshalling

                  sig {override.returns(T::Array[[T.untyped, Home]])}
                  def cases
                    [
                      [
                        {},
                        Home.new,
                      ],
                      [
                        {
                          "mailmerge" => true,
                        },
                        Home.new(
                          mailmerge: true,
                        ),
                      ],
                    ]
                  end
                end

                class ViewTest < ::Test::Unit::TestCase
                  extend T::Sig
                  include Test::StructMarshalling

                  sig {override.returns(T::Array[[T.untyped, View]])}
                  def cases
                    [
                      [
                        {},
                        View.new,
                      ],
                      [
                        {
                          "navigation" => true,
                        },
                        View.new(
                          navigation: true,
                        ),
                      ],
                    ]
                  end
                end
              end

              class ToolbarTest < ::Test::Unit::TestCase
                extend T::Sig
                include Test::StructMarshalling

                sig {override.returns(T::Array[[T.untyped, Toolbar]])}
                def cases
                  [
                    [
                      {},
                      Toolbar.new,
                    ],
                    [
                      {
                        "collaboration" => true,
                        "draw" => true,
                        "file" => true,
                        "home" => {
                          "mailmerge" => true,
                        },
                        "layout" => true,
                        "plugins" => true,
                        "protect" => true,
                        "references" => true,
                        "save" => true,
                        "view" => true,
                      },
                      Toolbar.new(
                        collaboration: true,
                        draw: true,
                        file: true,
                        home: Toolbar::Home.new(
                          mailmerge: true,
                        ),
                        layout: true,
                        plugins: true,
                        protect: true,
                        references: true,
                        save: true,
                        view: true,
                      ),
                    ],
                    [
                      {
                        "collaboration" => {
                          "mailmerge" => true,
                        },
                        "file" => {
                          "close" => true,
                        },
                        "view" => {
                          "navigation" => true,
                        },
                      },
                      Toolbar.new(
                        collaboration: Toolbar::Collaboration.new(
                          mailmerge: true,
                        ),
                        file: Toolbar::File.new(
                          close: true,
                        ),
                        view: Toolbar::View.new(
                          navigation: true,
                        ),
                      ),
                    ],
                  ]
                end
              end
            end

            class LayoutTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::StructMarshalling

              sig {override.returns(T::Array[[T.untyped, Layout]])}
              def cases
                [
                  [
                    {},
                    Layout.new,
                  ],
                  [
                    {
                      "header" => {
                        "editMode" => true,
                      },
                      "leftMenu" => true,
                      "rightMenu" => true,
                      "statusBar" => true,
                      "toolbar" => true,
                    },
                    Layout.new(
                      header: Layout::Header.new(
                        edit_mode: true,
                      ),
                      left_menu: true,
                      right_menu: true,
                      status_bar: true,
                      toolbar: true,
                    ),
                  ],
                  [
                    {
                      "leftMenu" => {
                        "menu" => true,
                      },
                      "rightMenu" => {
                        "mode" => true,
                      },
                      "statusBar" => {
                        "actionStatus" => true,
                      },
                      "toolbar" => {
                        "collaboration" => {},
                      },
                    },
                    Layout.new(
                      left_menu: Layout::LeftMenu.new(
                        menu: true,
                      ),
                      right_menu: Layout::RightMenu.new(
                        mode: true,
                      ),
                      status_bar: Layout::StatusBar.new(
                        action_status: true,
                      ),
                      toolbar: Layout::Toolbar.new(
                        collaboration: Layout::Toolbar::Collaboration.new,
                      ),
                    ),
                  ],
                ]
              end
            end

            class LogoTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::StructMarshalling

              sig {override.returns(T::Array[[T.untyped, Logo]])}
              def cases
                [
                  [
                    {},
                    Logo.new,
                  ],
                  [
                    {
                      "image" => "http://localhost:8080/",
                      "imageDark" => "http://localhost:8080/",
                      "imageLight" => "http://localhost:8080/",
                      "imageEmbedded" => "http://localhost:8080/",
                      "url" => "http://localhost:8080/",
                      "visible" => true,
                    },
                    Logo.new(
                      image: "http://localhost:8080/",
                      image_dark: "http://localhost:8080/",
                      image_light: "http://localhost:8080/",
                      image_embedded: "http://localhost:8080/",
                      url: "http://localhost:8080/",
                      visible: true,
                    ),
                  ],
                ]
              end
            end

            class MacrosModeTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::BasicEnumMarshalling

              sig {override.returns(T::Array[[String, MacrosMode]])}
              def cases
                [
                  ["disable", MacrosMode::Disable],
                  ["enable", MacrosMode::Enable],
                  ["warn", MacrosMode::Warn],
                ]
              end
            end

            class MobileTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::StructMarshalling

              sig {override.returns(T::Array[[T.untyped, Mobile]])}
              def cases
                [
                  [
                    {},
                    Mobile.new,
                  ],
                  [
                    {
                      "forceView" => true,
                      "info" => true,
                      "standardView" => true,
                    },
                    Mobile.new(
                      force_view: true,
                      info: true,
                      standard_view: true,
                    ),
                  ],
                ]
              end
            end

            class PointerModeTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::BasicEnumMarshalling

              sig {override.returns(T::Array[[String, PointerMode]])}
              def cases
                [
                  ["hand", PointerMode::Hand],
                  ["select", PointerMode::Select],
                ]
              end
            end

            class Review
              class ReviewDisplayTest < ::Test::Unit::TestCase
                extend T::Sig
                include Test::BasicEnumMarshalling

                sig {override.returns(T::Array[[String, ReviewDisplay]])}
                def cases
                  [
                    ["markup", ReviewDisplay::Markup],
                    ["simple", ReviewDisplay::Simple],
                    ["final", ReviewDisplay::Final],
                    ["original", ReviewDisplay::Original],
                  ]
                end
              end
            end

            class ReviewTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::StructMarshalling

              sig {override.returns(T::Array[[T.untyped, Review]])}
              def cases
                [
                  [
                    {},
                    Review.new,
                  ],
                  [
                    {
                      "hideReviewDisplay" => true,
                      "hoverMode" => true,
                      "reviewDisplay" => "markup",
                      "showReviewChanges" => true,
                      "trackChanges" => true,
                    },
                    Review.new(
                      hide_review_display: true,
                      hover_mode: true,
                      review_display: Review::ReviewDisplay::Markup,
                      show_review_changes: true,
                      track_changes: true,
                    ),
                  ],
                ]
              end
            end

            class SubmitFormTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::StructMarshalling

              sig {override.returns(T::Array[[T.untyped, SubmitForm]])}
              def cases
                [
                  [
                    {},
                    SubmitForm.new,
                  ],
                  [
                    {
                      "visible" => true,
                      "resultMessage" => "Success",
                    },
                    SubmitForm.new(
                      visible: true,
                      result_message: "Success",
                    ),
                  ],
                ]
              end
            end

            class UiThemeTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::BasicEnumMarshalling

              sig {override.returns(T::Array[[String, UiTheme]])}
              def cases
                [
                  ["theme-light", UiTheme::Light],
                  ["theme-classic-light", UiTheme::ClassicLight],
                  ["theme-dark", UiTheme::Dark],
                  ["theme-contrast-dark", UiTheme::ContrastDark],
                  ["default-dark", UiTheme::DefaultDark],
                  ["default-light", UiTheme::DefaultLight],
                ]
              end
            end

            class UnitTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::BasicEnumMarshalling

              sig {override.returns(T::Array[[String, Unit]])}
              def cases
                [
                  ["cm", Unit::Cm],
                  ["pt", Unit::Pt],
                  ["inch", Unit::Inch],
                ]
              end
            end
          end

          class CustomizationTest < ::Test::Unit::TestCase
            extend T::Sig
            include Test::StructMarshalling

            sig {override.returns(T::Array[[T.untyped, Customization]])}
            def cases
              [
                [
                  {},
                  Customization.new,
                ],
                [
                  {
                    "about" => true,
                    "anonymous" => {
                      "request" => true,
                    },
                    "autosave" => true,
                    "chat" => true,
                    "close" => {
                      "visible" => true,
                    },
                    "commentAuthorOnly" => true,
                    "comments" => true,
                    "compactHeader" => true,
                    "compactToolbar" => true,
                    "compatibleFeatures" => true,
                    "customer" => {
                      "address" => "Address",
                    },
                    "features" => {
                      "roles" => true,
                    },
                    "feedback" => true,
                    "font" => {
                      "name" => "Arial",
                    },
                    "forcesave" => true,
                    "goback" => {
                      "blank" => true,
                    },
                    "help" => true,
                    "hideNotes" => true,
                    "hideRightMenu" => true,
                    "hideRulers" => true,
                    "integrationMode" => "embed",
                    "layout" => {
                      "header" => {},
                    },
                    "leftMenu" => true,
                    "loaderLogo" => "http://localhost:8080/",
                    "loaderName" => "Loader",
                    "logo" => {
                      "image" => "http://localhost:8080/",
                    },
                    "macros" => true,
                    "macrosMode" => "disable",
                    "mentionShare" => true,
                    "mobile" => {
                      "forceView" => true,
                    },
                    "mobileForceView" => true,
                    "plugins" => true,
                    "pointerMode" => "hand",
                    "review" => {
                      "hideReviewDisplay" => true,
                    },
                    "reviewDisplay" => "markup",
                    "rightMenu" => true,
                    "showReviewChanges" => true,
                    "slidePlayerBackground" => "#000",
                    "spellcheck" => true,
                    "statusBar" => true,
                    "submitForm" => true,
                    "toolbar" => true,
                    "toolbarHideFileName" => true,
                    "toolbarNoTabs" => true,
                    "trackChanges" => true,
                    "uiTheme" => "theme-dark",
                    "unit" => "pt",
                    "wordHeadingsColor" => "#000",
                    "zoom" => 100,
                  },
                  Customization.new(
                    about: true,
                    anonymous: Customization::Anonymous.new(
                      request: true,
                    ),
                    autosave: true,
                    chat: true,
                    close: Customization::Close.new(
                      visible: true,
                    ),
                    comment_author_only: true,
                    comments: true,
                    compact_header: true,
                    compact_toolbar: true,
                    compatible_features: true,
                    customer: Customization::Customer.new(
                      address: "Address",
                    ),
                    features: Customization::Features.new(
                      roles: true,
                    ),
                    feedback: true,
                    font: Customization::Font.new(
                      name: "Arial",
                    ),
                    forcesave: true,
                    goback: Customization::GoBack.new(
                      blank: true,
                    ),
                    help: true,
                    hide_notes: true,
                    hide_right_menu: true,
                    hide_rulers: true,
                    integration_mode: Customization::IntegrationMode::Embed,
                    layout: Customization::Layout.new(
                      header: Customization::Layout::Header.new,
                    ),
                    left_menu: true,
                    loader_logo: "http://localhost:8080/",
                    loader_name: "Loader",
                    logo: Customization::Logo.new(
                      image: "http://localhost:8080/",
                    ),
                    macros: true,
                    macros_mode: Customization::MacrosMode::Disable,
                    mention_share: true,
                    mobile: Customization::Mobile.new(
                      force_view: true,
                    ),
                    mobile_force_view: true,
                    plugins: true,
                    pointer_mode: Customization::PointerMode::Hand,
                    review: Customization::Review.new(
                      hide_review_display: true,
                    ),
                    review_display: Customization::Review::ReviewDisplay::Markup,
                    right_menu: true,
                    show_review_changes: true,
                    slide_player_background: "#000",
                    spellcheck: true,
                    status_bar: true,
                    submit_form: true,
                    toolbar: true,
                    toolbar_hide_file_name: true,
                    toolbar_no_tabs: true,
                    track_changes: true,
                    ui_theme: Customization::UiTheme::Dark,
                    unit: Customization::Unit::Pt,
                    word_headings_color: "#000",
                    zoom: 100,
                  ),
                ],
                [
                  {
                    "feedback" => {
                      "url" => "http://localhost:8080/",
                    },
                    "submitForm" => {
                      "visible" => true,
                    },
                  },
                  Customization.new(
                    feedback: Customization::Feedback.new(
                      url: "http://localhost:8080/",
                    ),
                    submit_form: Customization::SubmitForm.new(
                      visible: true,
                    ),
                  ),
                ],
              ]
            end
          end

          class Embedded
            class ToolbarDockedTest < ::Test::Unit::TestCase
              extend T::Sig
              include Test::BasicEnumMarshalling

              sig {override.returns(T::Array[[String, ToolbarDocked]])}
              def cases
                [
                  ["top", ToolbarDocked::Top],
                  ["bottom", ToolbarDocked::Bottom],
                ]
              end
            end
          end

          class EmbeddedTest < ::Test::Unit::TestCase
            extend T::Sig
            include Test::StructMarshalling

            sig {override.returns(T::Array[[T.untyped, Embedded]])}
            def cases
              [
                [
                  {},
                  Embedded.new,
                ],
                [
                  {
                    "embedUrl" => "http://localhost:8080/",
                    "fullscreenUrl" => "http://localhost:8080/",
                    "saveUrl" => "http://localhost:8080/",
                    "shareUrl" => "http://localhost:8080/",
                    "toolbarDocked" => "top",
                  },
                  Embedded.new(
                    embed_url: "http://localhost:8080/",
                    fullscreen_url: "http://localhost:8080/",
                    save_url: "http://localhost:8080/",
                    share_url: "http://localhost:8080/",
                    toolbar_docked: Embedded::ToolbarDocked::Top,
                  ),
                ],
              ]
            end
          end

          class PluginsTest < ::Test::Unit::TestCase
            extend T::Sig
            include Test::StructMarshalling

            sig {override.returns(T::Array[[T.untyped, Plugins]])}
            def cases
              [
                [
                  {},
                  Plugins.new,
                ],
                [
                  {
                    "autostart" => ["plugin_1"],
                    "options" => {},
                    "pluginsData" => ["plugin_1"],
                    "url" => "http://localhost:8080/",
                  },
                  Plugins.new(
                    autostart: ["plugin_1"],
                    options: {},
                    plugins_data: ["plugin_1"],
                    url: "http://localhost:8080/",
                  ),
                ],
              ]
            end
          end
        end

        class EditorConfigTest < ::Test::Unit::TestCase
          extend T::Sig
          include Test::StructMarshalling

          sig {override.returns(T::Array[[T.untyped, EditorConfig]])}
          def cases
            [
              [
                {},
                EditorConfig.new,
              ],
              [
                {
                  "actionLink" => {},
                  "callbackUrl" => "http://localhost:8080/",
                  "coEditing" => {
                    "mode" => "fast",
                  },
                  "createUrl" => "http://localhost:8080/",
                  "lang" => "en",
                  "location" => "us",
                  "mode" => "edit",
                  "recent" => [
                    {
                      "folder" => "folder_1",
                    },
                  ],
                  "region" => "us",
                  "templates" => [
                    {
                      "image" => "http://localhost:8080/",
                    },
                  ],
                  "user" => {
                    "firstname" => "First",
                  },
                  "customization" => {
                    "about" => true,
                  },
                  "embedded" => {
                    "embedUrl" => "http://localhost:8080/",
                  },
                  "plugins" => {
                    "autostart" => ["plugin_1"],
                  },
                },
                EditorConfig.new(
                  action_link: {},
                  callback_url: "http://localhost:8080/",
                  co_editing: EditorConfig::CoEditing.new(
                    mode: EditorConfig::CoEditing::Mode::Fast,
                  ),
                  create_url: "http://localhost:8080/",
                  lang: "en",
                  location: "us",
                  mode: EditorConfig::Mode::Edit,
                  recent: [
                    EditorConfig::Recent.new(
                      folder: "folder_1",
                    ),
                  ],
                  region: "us",
                  templates: [
                    EditorConfig::Template.new(
                      image: "http://localhost:8080/",
                    ),
                  ],
                  user: EditorConfig::User.new(
                    firstname: "First",
                  ),
                  customization: EditorConfig::Customization.new(
                    about: true,
                  ),
                  embedded: EditorConfig::Embedded.new(
                    embed_url: "http://localhost:8080/",
                  ),
                  plugins: EditorConfig::Plugins.new(
                    autostart: ["plugin_1"],
                  ),
                ),
              ],
            ]
          end
        end
      end

      class ConfigTest < ::Test::Unit::TestCase
        extend T::Sig
        include Test::StructMarshalling

        sig {override.returns(T::Array[[T.untyped, Config]])}
        def cases
          [
            [
              {},
              Config.new,
            ],
            [
              {
                "documentType" => "text",
                "height" => "100%",
                "token" => "***",
                "type" => "desktop",
                "width" => "100%",
                "document" => {
                  "fileType" => "docx",
                },
                "editorConfig" => {
                  "actionLink" => {},
                },
              },
              Config.new(
                document_type: Config::DocumentType::Text,
                height: "100%",
                token: "***",
                type: Config::Type::Desktop,
                width: "100%",
                document: Config::Document.new(
                  file_type: "docx",
                ),
                editor_config: Config::EditorConfig.new(
                  action_link: {},
                ),
              ),
            ],
          ]
        end
      end
    end
  end
end
