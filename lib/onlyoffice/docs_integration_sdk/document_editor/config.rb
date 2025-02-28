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
    module DocumentEditor
      # @since 0.1.0
      class Config < T::Struct
        extend T::Sig

        # @since 0.1.0
        class DocumentType < T::Enum
          enums do
            # @since 0.1.0
            Word = new("word")

            # @since 0.1.0
            Cell = new("cell")

            # @since 0.1.0
            Slide = new("slide")

            # @since 0.1.0
            Pdf = new("pdf")

            # @deprecated Use {Word} instead. This property is deprecated since Document Server version 6.1.
            # @since 0.1.0
            Text = new("text")

            # @deprecated Use {Cell} instead. This property is deprecated since Document Server version 6.1.
            # @since 0.1.0
            Spreadsheet = new("spreadsheet")

            # @deprecated Use {Slide} instead. This property is deprecated since Document Server version 6.1.
            # @since 0.1.0
            Presentation = new("presentation")
          end
        end

        # @since 0.1.0
        class Type < T::Enum
          enums do
            # @since 0.1.0
            Desktop = new("desktop")

            # @since 0.1.0
            Mobile = new("mobile")

            # @since 0.1.0
            Embedded = new("embedded")
          end
        end

        # @since 0.1.0
        class Document < T::Struct
          extend T::Sig

          # @since 0.1.0
          class ReferenceData < T::Struct
            extend T::Sig

            # @since 0.1.0
            prop :file_key, T.nilable(String), name: "fileKey"

            # @since 0.1.0
            prop :instance_id, T.nilable(String), name: "instanceId"

            # @since 0.1.0
            prop :key, T.nilable(String), name: "key"

            # @since 0.1.0
            sig {params(hash: T.untyped, strict: T.untyped).returns(ReferenceData)}
            def self.from_hash(hash, strict = nil)
              super(hash, strict)
            end
          end

          # @since 0.1.0
          class Info < T::Struct
            extend T::Sig

            # @since 0.1.0
            class SharingSettings < T::Struct
              extend T::Sig

              # @since 0.1.0
              class Permissions < T::Enum
                enums do
                  # @since 0.1.0
                  FullAccess = new("Full Access")

                  # @since 0.1.0
                  ReadOnly = new("Read Only")

                  # @since 0.1.0
                  DenyAccess = new("Deny Access")
                end
              end

              # @since 0.1.0
              prop :is_link, T.nilable(T::Boolean), name: "isLink"

              # @since 0.1.0
              prop :permissions, T.nilable(Permissions), name: "permissions"

              # @since 0.1.0
              prop :user, T.nilable(String), name: "user"

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(SharingSettings)}
              def self.from_hash(hash, strict = nil)
                super(hash, strict)
              end
            end

            # @deprecated Use {owner} instead. This property is deprecated since Document Server version 5.4.
            # @since 0.1.0
            prop :author, T.nilable(String), name: "author"

            # @deprecated Use {uploaded} instead. This property is deprecated since Document Server version 5.4.
            # @since 0.1.0
            prop :created, T.nilable(String), name: "created"

            # @since 0.1.0
            prop :favorite, T.nilable(T::Boolean), name: "favorite"

            # @since 0.1.0
            prop :folder, T.nilable(String), name: "folder"

            # @since 0.1.0
            prop :owner, T.nilable(String), name: "owner"

            # @since 0.1.0
            prop :sharing_settings, T.nilable(T::Array[SharingSettings]), name: "sharingSettings"

            # @since 0.1.0
            prop :uploaded, T.nilable(String), name: "uploaded"

            # @since 0.1.0
            sig {params(hash: T.untyped, strict: T.untyped).returns(Info)}
            def self.from_hash(hash, strict = nil)
              super(hash, strict)
            end
          end

          # @since 0.1.0
          class Permissions < T::Struct
            extend T::Sig

            # @since 0.1.0
            class CommentGroup < T::Struct
              extend T::Sig

              # @since 0.1.0
              prop :edit, T.nilable(T::Array[String]), name: "edit"

              # @since 0.1.0
              prop :remove, T.nilable(T::Array[String]), name: "remove"

              # @since 0.1.0
              prop :view, T.nilable(T::Array[String]), name: "view"

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(CommentGroup)}
              def self.from_hash(hash, strict = nil)
                super(hash, strict)
              end
            end

            # @deprecated Use events.onRequestRestore instead. This property is deprecated since Document Server version 5.5.
            # @since 0.1.0
            prop :change_history, T.nilable(T::Boolean), name: "changeHistory"

            # @since 0.1.0
            prop :chat, T.nilable(T::Boolean), name: "chat"

            # @since 0.1.0
            prop :comment, T.nilable(T::Boolean), name: "comment"

            # @since 0.1.0
            prop :comment_groups, T.nilable(T::Array[CommentGroup]), name: "commentGroups"

            # @since 0.1.0
            prop :copy, T.nilable(T::Boolean), name: "copy"

            # @since 0.1.0
            prop :delete_comment_author_only, T.nilable(T::Boolean), name: "deleteCommentAuthorOnly"

            # @since 0.1.0
            prop :download, T.nilable(T::Boolean), name: "download"

            # @since 0.1.0
            prop :edit, T.nilable(T::Boolean), name: "edit"

            # @since 0.1.0
            prop :edit_comment_author_only, T.nilable(T::Boolean), name: "editCommentAuthorOnly"

            # @since 0.1.0
            prop :fill_forms, T.nilable(T::Boolean), name: "fillForms"

            # @since 0.1.0
            prop :modify_content_control, T.nilable(T::Boolean), name: "modifyContentControl"

            # @since 0.1.0
            prop :modify_filter, T.nilable(T::Boolean), name: "modifyFilter"

            # @since 0.1.0
            prop :print, T.nilable(T::Boolean), name: "print"

            # @since 0.1.0
            prop :protect, T.nilable(T::Boolean), name: "protect"

            # @deprecated Use events.onRequestRename instead. This property is deprecated since Document Server version 6.0.
            # @since 0.1.0
            prop :rename, T.nilable(T::Boolean), name: "rename"

            # @since 0.1.0
            prop :review, T.nilable(T::Boolean), name: "review"

            # @since 0.1.0
            prop :review_groups, T.nilable(T::Array[String]), name: "reviewGroups"

            # @since 0.1.0
            prop :user_info_groups, T.nilable(T::Array[String]), name: "userInfoGroups"

            # @since 0.1.0
            sig {params(hash: T.untyped, strict: T.untyped).returns(Permissions)}
            def self.from_hash(hash, strict = nil)
              super(hash, strict)
            end
          end

          # @since 0.1.0
          prop :file_type, T.nilable(String), name: "fileType"

          # @since 0.1.0
          prop :key, T.nilable(String), name: "key"

          # @since 0.1.0
          prop :reference_data, T.nilable(ReferenceData), name: "referenceData"

          # @since 0.1.0
          prop :title, T.nilable(String), name: "title"

          # @since 0.1.0
          prop :url, T.nilable(String), name: "url"

          # @since 0.1.0
          prop :info, T.nilable(Info), name: "info"

          # @since 0.1.0
          prop :permissions, T.nilable(Permissions), name: "permissions"

          # @since 0.1.0
          sig {params(hash: T.untyped, strict: T.untyped).returns(Document)}
          def self.from_hash(hash, strict = nil)
            super(hash, strict)
          end
        end

        # @since 0.1.0
        class EditorConfig < T::Struct
          extend T::Sig

          # @since 0.1.0
          class CoEditing < T::Struct
            extend T::Sig

            # @since 0.1.0
            class Mode < T::Enum
              enums do
                # @since 0.1.0
                Fast = new("fast")

                # @since 0.1.0
                Strict = new("strict")
              end
            end

            # @since 0.1.0
            prop :mode, T.nilable(Mode), name: "mode"

            # @since 0.1.0
            prop :change, T.nilable(T::Boolean), name: "change"

            # @since 0.1.0
            sig {params(hash: T.untyped, strict: T.untyped).returns(CoEditing)}
            def self.from_hash(hash, strict = nil)
              super(hash, strict)
            end
          end

          # @since 0.1.0
          class Mode < T::Enum
            enums do
              # @since 0.1.0
              View = new("view")

              # @since 0.1.0
              Edit = new("edit")
            end
          end

          # @since 0.1.0
          class Recent < T::Struct
            extend T::Sig

            # @since 0.1.0
            prop :folder, T.nilable(String), name: "folder"

            # @since 0.1.0
            prop :title, T.nilable(String), name: "title"

            # @since 0.1.0
            prop :url, T.nilable(String), name: "url"

            # @since 0.1.0
            sig {params(hash: T.untyped, strict: T.untyped).returns(Recent)}
            def self.from_hash(hash, strict = nil)
              super(hash, strict)
            end
          end

          # @since 0.1.0
          class Template < T::Struct
            extend T::Sig

            # @since 0.1.0
            prop :image, T.nilable(String), name: "image"

            # @since 0.1.0
            prop :title, T.nilable(String), name: "title"

            # @since 0.1.0
            prop :url, T.nilable(String), name: "url"

            # @since 0.1.0
            sig {params(hash: T.untyped, strict: T.untyped).returns(Template)}
            def self.from_hash(hash, strict = nil)
              super(hash, strict)
            end
          end

          # @since 0.1.0
          class User < T::Struct
            extend T::Sig

            # @deprecated Use {name} instead. This property is deprecated since Document Server version 4.2.
            # @since 0.1.0
            prop :firstname, T.nilable(String), name: "firstname"

            # @since 0.1.0
            prop :group, T.nilable(String), name: "group"

            # @since 0.1.0
            prop :id, T.nilable(String), name: "id"

            # @since 0.1.0
            prop :image, T.nilable(String), name: "image"

            # @deprecated Use {name} instead. This property is deprecated since Document Server version 4.2.
            # @since 0.1.0
            prop :lastname, T.nilable(String), name: "lastname"

            # @since 0.1.0
            prop :name, T.nilable(String), name: "name"

            # @since 0.1.0
            sig {params(hash: T.untyped, strict: T.untyped).returns(User)}
            def self.from_hash(hash, strict = nil)
              super(hash, strict)
            end
          end

          # @since 0.1.0
          class Customization < T::Struct
            extend T::Sig

            # @since 0.1.0
            class Anonymous < T::Struct
              extend T::Sig

              # @since 0.1.0
              prop :request, T.nilable(T::Boolean), name: "request"

              # @since 0.1.0
              prop :label, T.nilable(String), name: "label"

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(Anonymous)}
              def self.from_hash(hash, strict = nil)
                super(hash, strict)
              end
            end

            # @since 0.1.0
            class Close < T::Struct
              extend T::Sig

              # @since 0.1.0
              prop :visible, T.nilable(T::Boolean), name: "visible"

              # @since 0.1.0
              prop :text, T.nilable(String), name: "text"

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(Close)}
              def self.from_hash(hash, strict = nil)
                super(hash, strict)
              end
            end

            # @since 0.1.0
            class Customer < T::Struct
              extend T::Sig

              # @since 0.1.0
              prop :address, T.nilable(String), name: "address"

              # @since 0.1.0
              prop :info, T.nilable(String), name: "info"

              # @since 0.1.0
              prop :logo, T.nilable(String), name: "logo"

              # @since 0.1.0
              prop :logo_dark, T.nilable(String), name: "logoDark"

              # @since 0.1.0
              prop :mail, T.nilable(String), name: "mail"

              # @since 0.1.0
              prop :name, T.nilable(String), name: "name"

              # @since 0.1.0
              prop :phone, T.nilable(String), name: "phone"

              # @since 0.1.0
              prop :www, T.nilable(String), name: "www"

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(Customer)}
              def self.from_hash(hash, strict = nil)
                super(hash, strict)
              end
            end

            # @since 0.1.0
            class Features < T::Struct
              extend T::Sig

              # @since 0.1.0
              class Spellcheck < T::Struct
                extend T::Sig

                # @since 0.1.0
                prop :mode, T.nilable(T::Boolean), name: "mode"

                # @since 0.1.0
                prop :change, T.nilable(T::Boolean), name: "change"

                # @since 0.1.0
                sig {params(hash: T.untyped, strict: T.untyped).returns(Spellcheck)}
                def self.from_hash(hash, strict = nil)
                  super(hash, strict)
                end
              end

              # @since 0.1.0
              class TabBackground < T::Struct
                extend T::Sig

                # @since 0.1.0
                class Mode < T::Enum
                  enums do
                    # @since 0.1.0
                    Header = new("header")

                    # @since 0.1.0
                    Toolbar = new("toolbar")
                  end
                end

                # @since 0.1.0
                prop :mode, T.nilable(Mode), name: "mode"

                # @since 0.1.0
                prop :change, T.nilable(T::Boolean), name: "change"

                # @since 0.1.0
                sig {params(hash: T.untyped, strict: T.untyped).returns(TabBackground)}
                def self.from_hash(hash, strict = nil)
                  super(hash, strict)
                end
              end

              # @since 0.1.0
              class TabStyle < T::Struct
                extend T::Sig

                # @since 0.1.0
                class Mode < T::Enum
                  enums do
                    # @since 0.1.0
                    Fill = new("fill")

                    # @since 0.1.0
                    Line = new("line")
                  end
                end

                # @since 0.1.0
                prop :mode, T.nilable(Mode), name: "mode"

                # @since 0.1.0
                prop :change, T.nilable(T::Boolean), name: "change"

                # @since 0.1.0
                sig {params(hash: T.untyped, strict: T.untyped).returns(TabStyle)}
                def self.from_hash(hash, strict = nil)
                  super(hash, strict)
                end
              end

              # @since 0.1.0
              prop :roles, T.nilable(T::Boolean), name: "roles"

              # @since 0.1.0
              prop :spellcheck, T.nilable(T.any(Spellcheck, T::Boolean)), name: "spellcheck"

              # @since 0.1.0
              prop :tab_background, T.nilable(T.any(TabBackground, TabBackground::Mode)), name: "tabBackground"

              # @since 0.1.0
              prop :tab_style, T.nilable(T.any(TabStyle, TabStyle::Mode)), name: "tabStyle"

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(Features)}
              def self.from_hash(hash, strict = nil)
                s = T.cast(super(hash, strict), Features)

                spellcheck_v = s.spellcheck
                if !spellcheck_v.nil? && !spellcheck_v.is_a?(TrueClass) && !spellcheck_v.is_a?(FalseClass)
                  s.spellcheck = Spellcheck.from_hash(spellcheck_v, strict)
                end

                tab_background_v = T.cast(s.tab_background, T.nilable(T.any(T::Hash[T.untyped, T.untyped], String)))
                if !tab_background_v.nil? && tab_background_v.is_a?(String)
                  s.tab_background = TabBackground::Mode.from_serialized(tab_background_v)
                elsif !tab_background_v.nil? && tab_background_v.is_a?(Hash)
                  s.tab_background = TabBackground.from_hash(tab_background_v, strict)
                end

                tab_style_v = T.cast(s.tab_style, T.nilable(T.any(T::Hash[T.untyped, T.untyped], String)))
                if !tab_style_v.nil? && tab_style_v.is_a?(String)
                  s.tab_style = TabStyle::Mode.from_serialized(tab_style_v)
                elsif !tab_style_v.nil? && tab_style_v.is_a?(Hash)
                  s.tab_style = TabStyle.from_hash(tab_style_v, strict)
                end

                s
              end

              # @since 0.1.0
              sig {params(strict: T.untyped).returns(T.untyped)}
              def serialize(strict = nil)
                h = T.cast(super(strict), T::Hash[T.untyped, T.untyped])

                spellcheck_v = spellcheck
                if !spellcheck_v.nil? && !spellcheck_v.is_a?(TrueClass) && !spellcheck_v.is_a?(FalseClass)
                  h[Features.props[:spellcheck][:name] || "spellcheck"] = spellcheck_v.serialize(strict)
                end

                tab_background_v = tab_background
                if !tab_background_v.nil? && tab_background_v.is_a?(TabBackground::Mode)
                  h[Features.props[:tab_background][:name] || "tab_background"] = tab_background_v.serialize
                elsif !tab_background_v.nil? && tab_background_v.is_a?(TabBackground)
                  h[Features.props[:tab_background][:name] || "tab_background"] = tab_background_v.serialize(strict)
                end

                tab_style_v = tab_style
                if !tab_style_v.nil? && tab_style_v.is_a?(TabStyle::Mode)
                  h[Features.props[:tab_style][:name] || "tab_style"] = tab_style_v.serialize
                elsif !tab_style_v.nil? && tab_style_v.is_a?(TabStyle)
                  h[Features.props[:tab_style][:name] || "tab_style"] = tab_style_v.serialize(strict)
                end

                h
              end
            end

            # @since 0.1.0
            class Feedback < T::Struct
              extend T::Sig

              # @since 0.1.0
              prop :url, T.nilable(String), name: "url"

              # @since 0.1.0
              prop :visible, T.nilable(T::Boolean), name: "visible"

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(Feedback)}
              def self.from_hash(hash, strict = nil)
                super(hash, strict)
              end
            end

            # @since 0.1.0
            class Font < T::Struct
              extend T::Sig

              # @since 0.1.0
              prop :name, T.nilable(String), name: "name"

              # @since 0.1.0
              prop :size, T.nilable(String), name: "size"

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(Font)}
              def self.from_hash(hash, strict = nil)
                super(hash, strict)
              end
            end

            # @since 0.1.0
            class GoBack < T::Struct
              extend T::Sig

              # @since 0.1.0
              prop :blank, T.nilable(T::Boolean), name: "blank"

              # @deprecated Use onRequestClose instead. This property is deprecated since Document Server version 8.1.
              # @since 0.1.0
              prop :request_close, T.nilable(T::Boolean), name: "requestClose"

              # @since 0.1.0
              prop :text, T.nilable(String), name: "text"

              # @since 0.1.0
              prop :url, T.nilable(String), name: "url"

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(GoBack)}
              def self.from_hash(hash, strict = nil)
                super(hash, strict)
              end
            end

            # @since 0.1.0
            class IntegrationMode < T::Enum
              enums do
                # @since 0.1.0
                Embed = new("embed")
              end
            end

            # @since 0.1.0
            class Layout < T::Struct
              extend T::Sig

              # @since 0.1.0
              class Header < T::Struct
                extend T::Sig

                # @since 0.1.0
                prop :edit_mode, T.nilable(T::Boolean), name: "editMode"

                # @since 0.1.0
                prop :save, T.nilable(T::Boolean), name: "save"

                # @since 0.1.0
                prop :users, T.nilable(T::Boolean), name: "users"

                # @since 0.1.0
                sig {params(hash: T.untyped, strict: T.untyped).returns(Header)}
                def self.from_hash(hash, strict = nil)
                  super(hash, strict)
                end
              end

              # @since 0.1.0
              class LeftMenu < T::Struct
                extend T::Sig

                # @since 0.1.0
                prop :menu, T.nilable(T::Boolean), name: "menu"

                # @since 0.1.0
                prop :navigation, T.nilable(T::Boolean), name: "navigation"

                # @since 0.1.0
                prop :spellcheck, T.nilable(T::Boolean), name: "spellcheck"

                # @since 0.1.0
                sig {params(hash: T.untyped, strict: T.untyped).returns(LeftMenu)}
                def self.from_hash(hash, strict = nil)
                  super(hash, strict)
                end
              end

              # @since 0.1.0
              class RightMenu < T::Struct
                extend T::Sig

                # @since 0.1.0
                prop :mode, T.nilable(T::Boolean), name: "mode"

                # @since 0.1.0
                sig {params(hash: T.untyped, strict: T.untyped).returns(RightMenu)}
                def self.from_hash(hash, strict = nil)
                  super(hash, strict)
                end
              end

              # @since 0.1.0
              class StatusBar < T::Struct
                extend T::Sig

                # @since 0.1.0
                prop :action_status, T.nilable(T::Boolean), name: "actionStatus"

                # @since 0.1.0
                prop :doc_lang, T.nilable(T::Boolean), name: "docLang"

                # @since 0.1.0
                prop :text_lang, T.nilable(T::Boolean), name: "textLang"

                # @since 0.1.0
                sig {params(hash: T.untyped, strict: T.untyped).returns(StatusBar)}
                def self.from_hash(hash, strict = nil)
                  super(hash, strict)
                end
              end

              # @since 0.1.0
              class Toolbar < T::Struct
                extend T::Sig

                # @since 0.1.0
                class Collaboration < T::Struct
                  extend T::Sig

                  # @since 0.1.0
                  prop :mailmerge, T.nilable(T::Boolean), name: "mailmerge"

                  # @since 0.1.0
                  sig {params(hash: T.untyped, strict: T.untyped).returns(Collaboration)}
                  def self.from_hash(hash, strict = nil)
                    super(hash, strict)
                  end
                end

                # @since 0.1.0
                class File < T::Struct
                  extend T::Sig

                  # @since 0.1.0
                  prop :close, T.nilable(T::Boolean), name: "close"

                  # @since 0.1.0
                  prop :info, T.nilable(T::Boolean), name: "info"

                  # @since 0.1.0
                  prop :save, T.nilable(T::Boolean), name: "save"

                  # @since 0.1.0
                  prop :settings, T.nilable(T::Boolean), name: "settings"

                  # @since 0.1.0
                  sig {params(hash: T.untyped, strict: T.untyped).returns(File)}
                  def self.from_hash(hash, strict = nil)
                    super(hash, strict)
                  end
                end

                # @since 0.1.0
                class Home < T::Struct
                  extend T::Sig

                  # @since 0.1.0
                  prop :mailmerge, T.nilable(T::Boolean), name: "mailmerge"

                  # @since 0.1.0
                  sig {params(hash: T.untyped, strict: T.untyped).returns(Home)}
                  def self.from_hash(hash, strict = nil)
                    super(hash, strict)
                  end
                end

                # @since 0.1.0
                class View < T::Struct
                  extend T::Sig

                  # @since 0.1.0
                  prop :navigation, T.nilable(T::Boolean), name: "navigation"

                  # @since 0.1.0
                  sig {params(hash: T.untyped, strict: T.untyped).returns(View)}
                  def self.from_hash(hash, strict = nil)
                    super(hash, strict)
                  end
                end

                # @since 0.1.0
                prop :collaboration, T.nilable(T.any(Collaboration, T::Boolean)), name: "collaboration"

                # @since 0.1.0
                prop :draw, T.nilable(T::Boolean), name: "draw"

                # @since 0.1.0
                prop :file, T.nilable(T.any(File, T::Boolean)), name: "file"

                # @deprecated Use {Collaboration.mailmerge} instead.
                # @since 0.1.0
                prop :home, T.nilable(Home), name: "home"

                # @since 0.1.0
                prop :layout, T.nilable(T::Boolean), name: "layout"

                # @since 0.1.0
                prop :plugins, T.nilable(T::Boolean), name: "plugins"

                # @since 0.1.0
                prop :protect, T.nilable(T::Boolean), name: "protect"

                # @since 0.1.0
                prop :references, T.nilable(T::Boolean), name: "references"

                # @since 0.1.0
                prop :save, T.nilable(T::Boolean), name: "save"

                # @since 0.1.0
                prop :view, T.nilable(T.any(View, T::Boolean)), name: "view"

                # @since 0.1.0
                sig {params(hash: T.untyped, strict: T.untyped).returns(Toolbar)}
                def self.from_hash(hash, strict = nil)
                  s = T.cast(super(hash, strict), Toolbar)

                  collaboration_v = s.collaboration
                  if !collaboration_v.nil? && !collaboration_v.is_a?(TrueClass) && !collaboration_v.is_a?(FalseClass)
                    s.collaboration = Collaboration.from_hash(collaboration_v, strict)
                  end

                  file_v = s.file
                  if !file_v.nil? && !file_v.is_a?(TrueClass) && !file_v.is_a?(FalseClass)
                    s.file = File.from_hash(file_v, strict)
                  end

                  view_v = s.view
                  if !view_v.nil? && !view_v.is_a?(TrueClass) && !view_v.is_a?(FalseClass)
                    s.view = View.from_hash(view_v, strict)
                  end

                  s
                end

                # @since 0.1.0
                sig {params(strict: T.untyped).returns(T.untyped)}
                def serialize(strict = nil)
                  h = T.cast(super(strict), T::Hash[T.untyped, T.untyped])

                  collaboration_v = collaboration
                  if !collaboration_v.nil? && !collaboration_v.is_a?(TrueClass) && !collaboration_v.is_a?(FalseClass)
                    h[Toolbar.props[:collaboration][:name] || "collaboration"] = collaboration_v.serialize(strict)
                  end

                  file_v = file
                  if !file_v.nil? && !file_v.is_a?(TrueClass) && !file_v.is_a?(FalseClass)
                    h[Toolbar.props[:file][:name] || "file"] = file_v.serialize(strict)
                  end

                  view_v = view
                  if !view_v.nil? && !view_v.is_a?(TrueClass) && !view_v.is_a?(FalseClass)
                    h[Toolbar.props[:view][:name] || "view"] = view_v.serialize(strict)
                  end

                  h
                end
              end

              # @since 0.1.0
              prop :header, T.nilable(Header), name: "header"

              # @since 0.1.0
              prop :left_menu, T.nilable(T.any(LeftMenu, T::Boolean)), name: "leftMenu"

              # @since 0.1.0
              prop :right_menu, T.nilable(T.any(RightMenu, T::Boolean)), name: "rightMenu"

              # @since 0.1.0
              prop :status_bar, T.nilable(T.any(StatusBar, T::Boolean)), name: "statusBar"

              # @since 0.1.0
              prop :toolbar, T.nilable(T.any(Toolbar, T::Boolean)), name: "toolbar"

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(Layout)}
              def self.from_hash(hash, strict = nil)
                s = T.cast(super(hash, strict), Layout)

                left_menu_v = s.left_menu
                if !left_menu_v.nil? && !left_menu_v.is_a?(TrueClass) && !left_menu_v.is_a?(FalseClass)
                  s.left_menu = LeftMenu.from_hash(left_menu_v, strict)
                end

                right_menu_v = s.right_menu
                if !right_menu_v.nil? && !right_menu_v.is_a?(TrueClass) && !right_menu_v.is_a?(FalseClass)
                  s.right_menu = RightMenu.from_hash(right_menu_v, strict)
                end

                status_bar_v = s.status_bar
                if !status_bar_v.nil? && !status_bar_v.is_a?(TrueClass) && !status_bar_v.is_a?(FalseClass)
                  s.status_bar = StatusBar.from_hash(status_bar_v, strict)
                end

                toolbar_v = s.toolbar
                if !toolbar_v.nil? && !toolbar_v.is_a?(TrueClass) && !toolbar_v.is_a?(FalseClass)
                  s.toolbar = Toolbar.from_hash(toolbar_v, strict)
                end

                s
              end

              # @since 0.1.0
              sig {params(strict: T.untyped).returns(T.untyped)}
              def serialize(strict = nil)
                h = T.cast(super(strict), T::Hash[T.untyped, T.untyped])

                left_menu_v = left_menu
                if !left_menu_v.nil? && !left_menu_v.is_a?(TrueClass) && !left_menu_v.is_a?(FalseClass)
                  h[Layout.props[:left_menu][:name] || "left_menu"] = left_menu_v.serialize(strict)
                end

                right_menu_v = right_menu
                if !right_menu_v.nil? && !right_menu_v.is_a?(TrueClass) && !right_menu_v.is_a?(FalseClass)
                  h[Layout.props[:right_menu][:name] || "right_menu"] = right_menu_v.serialize(strict)
                end

                status_bar_v = status_bar
                if !status_bar_v.nil? && !status_bar_v.is_a?(TrueClass) && !status_bar_v.is_a?(FalseClass)
                  h[Layout.props[:status_bar][:name] || "status_bar"] = status_bar_v.serialize(strict)
                end

                toolbar_v = toolbar
                if !toolbar_v.nil? && !toolbar_v.is_a?(TrueClass) && !toolbar_v.is_a?(FalseClass)
                  h[Layout.props[:toolbar][:name] || "toolbar"] = toolbar_v.serialize(strict)
                end

                h
              end
            end

            # @since 0.1.0
            class Logo < T::Struct
              extend T::Sig

              # @since 0.1.0
              prop :image, T.nilable(String), name: "image"

              # @since 0.1.0
              prop :image_dark, T.nilable(String), name: "imageDark"

              # @since 0.1.0
              prop :image_light, T.nilable(String), name: "imageLight"

              # @since 0.1.0
              prop :image_embedded, T.nilable(String), name: "imageEmbedded"

              # @since 0.1.0
              prop :url, T.nilable(String), name: "url"

              # @since 0.1.0
              prop :visible, T.nilable(T::Boolean), name: "visible"

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(Logo)}
              def self.from_hash(hash, strict = nil)
                super(hash, strict)
              end
            end

            # @since 0.1.0
            class MacrosMode < T::Enum
              enums do
                # @since 0.1.0
                Disable = new("disable")

                # @since 0.1.0
                Enable = new("enable")

                # @since 0.1.0
                Warn = new("warn")
              end
            end

            # @since 0.1.0
            class Mobile < T::Struct
              extend T::Sig

              # @since 0.1.0
              prop :force_view, T.nilable(T::Boolean), name: "forceView"

              # @since 0.1.0
              prop :info, T.nilable(T::Boolean), name: "info"

              # @since 0.1.0
              prop :standard_view, T.nilable(T::Boolean), name: "standardView"

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(Mobile)}
              def self.from_hash(hash, strict = nil)
                super(hash, strict)
              end
            end

            # @since 0.1.0
            class PointerMode < T::Enum
              enums do
                # @since 0.1.0
                Hand = new("hand")

                # @since 0.1.0
                Select = new("select")
              end
            end

            # @since 0.1.0
            class Review < T::Struct
              extend T::Sig

              # @since 0.1.0
              class ReviewDisplay < T::Enum
                enums do
                  # @since 0.1.0
                  Markup = new("markup")

                  # @since 0.1.0
                  Simple = new("simple")

                  # @since 0.1.0
                  Final = new("final")

                  # @since 0.1.0
                  Original = new("original")
                end
              end

              # @since 0.1.0
              prop :hide_review_display, T.nilable(T::Boolean), name: "hideReviewDisplay"

              # @since 0.1.0
              prop :hover_mode, T.nilable(T::Boolean), name: "hoverMode"

              # @since 0.1.0
              prop :review_display, T.nilable(ReviewDisplay), name: "reviewDisplay"

              # @since 0.1.0
              prop :show_review_changes, T.nilable(T::Boolean), name: "showReviewChanges"

              # @since 0.1.0
              prop :track_changes, T.nilable(T::Boolean), name: "trackChanges"

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(Review)}
              def self.from_hash(hash, strict = nil)
                super(hash, strict)
              end
            end

            # @since 0.1.0
            class SubmitForm < T::Struct
              extend T::Sig

              # @since 0.1.0
              prop :visible, T.nilable(T::Boolean), name: "visible"

              # @since 0.1.0
              prop :result_message, T.nilable(String), name: "resultMessage"

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(SubmitForm)}
              def self.from_hash(hash, strict = nil)
                super(hash, strict)
              end
            end

            # @since 0.1.0
            class UiTheme < T::Enum
              enums do
                # @since 0.1.0
                Light = new("theme-light")

                # @since 0.1.0
                ClassicLight = new("theme-classic-light")

                # @since 0.1.0
                Dark = new("theme-dark")

                # @since 0.1.0
                ContrastDark = new("theme-contrast-dark")

                # @since 0.1.0
                DefaultDark = new("default-dark")

                # @since 0.1.0
                DefaultLight = new("default-light")
              end
            end

            # @since 0.1.0
            class Unit < T::Enum
              enums do
                # @since 0.1.0
                Cm = new("cm")

                # @since 0.1.0
                Pt = new("pt")

                # @since 0.1.0
                Inch = new("inch")
              end
            end

            # @since 0.1.0
            prop :about, T.nilable(T::Boolean), name: "about"

            # @since 0.1.0
            prop :anonymous, T.nilable(Anonymous), name: "anonymous"

            # @since 0.1.0
            prop :autosave, T.nilable(T::Boolean), name: "autosave"

            # @deprecated Use {::Onlyoffice::DocsIntegrationSdk::DocumentEditor::Config::Document::Permissions.chat} instead. This property is deprecated since Document Server version 7.1.
            # @since 0.1.0
            prop :chat, T.nilable(T::Boolean), name: "chat"

            # @since 0.1.0
            prop :close, T.nilable(Close), name: "close"

            # @deprecated Use {::Onlyoffice::DocsIntegrationSdk::DocumentEditor::Config::Document::Permissions.edit_comment_author_only} and {::Onlyoffice::DocsIntegrationSdk::DocumentEditor::Config::Document::Permissions.delete_comment_author_only} instead. This property is deprecated since Document Server version 6.3.
            # @since 0.1.0
            prop :comment_author_only, T.nilable(T::Boolean), name: "commentAuthorOnly"

            # @since 0.1.0
            prop :comments, T.nilable(T::Boolean), name: "comments"

            # @since 0.1.0
            prop :compact_header, T.nilable(T::Boolean), name: "compactHeader"

            # @since 0.1.0
            prop :compact_toolbar, T.nilable(T::Boolean), name: "compactToolbar"

            # @since 0.1.0
            prop :compatible_features, T.nilable(T::Boolean), name: "compatibleFeatures"

            # @since 0.1.0
            prop :customer, T.nilable(Customer), name: "customer"

            # @since 0.1.0
            prop :features, T.nilable(Features), name: "features"

            # @since 0.1.0
            prop :feedback, T.nilable(T.any(Feedback, T::Boolean)), name: "feedback"

            # @since 0.1.0
            prop :font, T.nilable(Font), name: "font"

            # @since 0.1.0
            prop :forcesave, T.nilable(T::Boolean), name: "forcesave"

            # @since 0.1.0
            prop :goback, T.nilable(GoBack), name: "goback"

            # @since 0.1.0
            prop :help, T.nilable(T::Boolean), name: "help"

            # @since 0.1.0
            prop :hide_notes, T.nilable(T::Boolean), name: "hideNotes"

            # @since 0.1.0
            prop :hide_right_menu, T.nilable(T::Boolean), name: "hideRightMenu"

            # @since 0.1.0
            prop :hide_rulers, T.nilable(T::Boolean), name: "hideRulers"

            # @since 0.1.0
            prop :integration_mode, T.nilable(IntegrationMode), name: "integrationMode"

            # @since 0.1.0
            prop :layout, T.nilable(Layout), name: "layout"

            # @deprecated Use {Layout.left_menu} instead. This property is deprecated since Document Server version 7.1.
            # @since 0.1.0
            prop :left_menu, T.nilable(T::Boolean), name: "leftMenu"

            # @since 0.1.0
            prop :loader_logo, T.nilable(String), name: "loaderLogo"

            # @since 0.1.0
            prop :loader_name, T.nilable(String), name: "loaderName"

            # @since 0.1.0
            prop :logo, T.nilable(Logo), name: "logo"

            # @since 0.1.0
            prop :macros, T.nilable(T::Boolean), name: "macros"

            # @since 0.1.0
            prop :macros_mode, T.nilable(MacrosMode), name: "macrosMode"

            # @since 0.1.0
            prop :mention_share, T.nilable(T::Boolean), name: "mentionShare"

            # @since 0.1.0
            prop :mobile, T.nilable(Mobile), name: "mobile"

            # @deprecated Use {mobile} instead. This property is deprecated since Document Server version 8.2.
            # @since 0.1.0
            prop :mobile_force_view, T.nilable(T::Boolean), name: "mobileForceView"

            # @since 0.1.0
            prop :plugins, T.nilable(T::Boolean), name: "plugins"

            # @since 0.1.0
            prop :pointer_mode, T.nilable(PointerMode), name: "pointerMode"

            # @since 0.1.0
            prop :review, T.nilable(Review), name: "review"

            # @deprecated Use {Review.review_display} instead. This property is deprecated since Document Server version 7.0.
            # @since 0.1.0
            prop :review_display, T.nilable(Review::ReviewDisplay), name: "reviewDisplay"

            # @deprecated Use {Layout.right_menu} instead. This property is deprecated since Document Server version 7.1.
            # @since 0.1.0
            prop :right_menu, T.nilable(T::Boolean), name: "rightMenu"

            # @deprecated Use {Review.show_review_changes} instead. This property is deprecated since Document Server version 7.0.
            # @since 0.1.0
            prop :show_review_changes, T.nilable(T::Boolean), name: "showReviewChanges"

            # @since 0.1.0
            prop :slide_player_background, T.nilable(String), name: "slidePlayerBackground"

            # @deprecated Use {Features.spellcheck} instead. This property is deprecated since Document Server version 7.1.
            # @since 0.1.0
            prop :spellcheck, T.nilable(T::Boolean), name: "spellcheck"

            # @deprecated Use {Layout.status_bar} instead. This property is deprecated since Document Server version 7.1.
            # @since 0.1.0
            prop :status_bar, T.nilable(T::Boolean), name: "statusBar"

            # @since 0.1.0
            prop :submit_form, T.nilable(T.any(SubmitForm, T::Boolean)), name: "submitForm"

            # @deprecated Use {Layout.toolbar} instead. This property is deprecated since Document Server version 7.1.
            # @since 0.1.0
            prop :toolbar, T.nilable(T::Boolean), name: "toolbar"

            # @since 0.1.0
            prop :toolbar_hide_file_name, T.nilable(T::Boolean), name: "toolbarHideFileName"

            # @deprecated Use {Features.tab_style} and {Features.tab_background} instead. This property is deprecated since Document Server version 8.2.
            # @since 0.1.0
            prop :toolbar_no_tabs, T.nilable(T::Boolean), name: "toolbarNoTabs"

            # @deprecated Use {Review.track_changes} instead. This property is deprecated since Document Server version 7.0.
            # @since 0.1.0
            prop :track_changes, T.nilable(T::Boolean), name: "trackChanges"

            # @since 0.1.0
            prop :ui_theme, T.nilable(UiTheme), name: "uiTheme"

            # @since 0.1.0
            prop :unit, T.nilable(Unit), name: "unit"

            # @since 0.1.0
            prop :word_headings_color, T.nilable(String), name: "wordHeadingsColor"

            # @since 0.1.0
            prop :zoom, T.nilable(Integer), name: "zoom"

            # @since 0.1.0
            sig {params(hash: T.untyped, strict: T.untyped).returns(Customization)}
            def self.from_hash(hash, strict = nil)
              s = T.cast(super(hash, strict), Customization)

              feedback_v = s.feedback
              if !feedback_v.nil? && !feedback_v.is_a?(TrueClass) && !feedback_v.is_a?(FalseClass)
                s.feedback = Feedback.from_hash(feedback_v, strict)
              end

              submit_form_v = s.submit_form
              if !submit_form_v.nil? && !submit_form_v.is_a?(TrueClass) && !submit_form_v.is_a?(FalseClass)
                s.submit_form = SubmitForm.from_hash(submit_form_v, strict)
              end

              s
            end

            # @since 0.1.0
            sig {params(strict: T.untyped).returns(T.untyped)}
            def serialize(strict = nil)
              h = T.cast(super(strict), T::Hash[T.untyped, T.untyped])

              feedback_v = feedback
              if !feedback_v.nil? && !feedback_v.is_a?(TrueClass) && !feedback_v.is_a?(FalseClass)
                h[Customization.props[:feedback][:name] || "feedback"] = feedback_v.serialize(strict)
              end

              submit_form_v = submit_form
              if !submit_form_v.nil? && !submit_form_v.is_a?(TrueClass) && !submit_form_v.is_a?(FalseClass)
                h[Customization.props[:submit_form][:name] || "submitForm"] = submit_form_v.serialize(strict)
              end

              h
            end
          end

          # @since 0.1.0
          class Embedded < T::Struct
            extend T::Sig

            # @since 0.1.0
            class ToolbarDocked < T::Enum
              enums do
                # @since 0.1.0
                Top = new("top")

                # @since 0.1.0
                Bottom = new("bottom")
              end
            end

            # @since 0.1.0
            prop :embed_url, T.nilable(String), name: "embedUrl"

            # @since 0.1.0
            prop :fullscreen_url, T.nilable(String), name: "fullscreenUrl"

            # @since 0.1.0
            prop :save_url, T.nilable(String), name: "saveUrl"

            # @since 0.1.0
            prop :share_url, T.nilable(String), name: "shareUrl"

            # @since 0.1.0
            prop :toolbar_docked, T.nilable(ToolbarDocked), name: "toolbarDocked"

            # @since 0.1.0
            sig {params(hash: T.untyped, strict: T.untyped).returns(Embedded)}
            def self.from_hash(hash, strict = nil)
              super(hash, strict)
            end
          end

          # @since 0.1.0
          class Plugins < T::Struct
            extend T::Sig

            # @since 0.1.0
            prop :autostart, T.nilable(T::Array[String]), name: "autostart"

            # @since 0.1.0
            prop :options, T.nilable(T::Hash[T.untyped, T.untyped]), name: "options"

            # @since 0.1.0
            prop :plugins_data, T.nilable(T::Array[String]), name: "pluginsData"

            # @since 0.1.0
            prop :url, T.nilable(String), name: "url"

            # @since 0.1.0
            sig {params(hash: T.untyped, strict: T.untyped).returns(Plugins)}
            def self.from_hash(hash, strict = nil)
              super(hash, strict)
            end
          end

          # @since 0.1.0
          prop :action_link, T.nilable(T::Hash[T.untyped, T.untyped]), name: "actionLink"

          # @since 0.1.0
          prop :callback_url, T.nilable(String), name: "callbackUrl"

          # @since 0.1.0
          prop :co_editing, T.nilable(CoEditing), name: "coEditing"

          # @since 0.1.0
          prop :create_url, T.nilable(String), name: "createUrl"

          # @since 0.1.0
          prop :lang, T.nilable(String), name: "lang"

          # @deprecated Use {region} instead. This property is deprecated since Document Server version 8.2.
          # @since 0.1.0
          prop :location, T.nilable(String), name: "location"

          # @since 0.1.0
          prop :mode, T.nilable(Mode), name: "mode"

          # @since 0.1.0
          prop :recent, T.nilable(T::Array[Recent]), name: "recent"

          # @since 0.1.0
          prop :region, T.nilable(String), name: "region"

          # @since 0.1.0
          prop :templates, T.nilable(T::Array[Template]), name: "templates"

          # @since 0.1.0
          prop :user, T.nilable(User), name: "user"

          # @since 0.1.0
          prop :customization, T.nilable(Customization), name: "customization"

          # @since 0.1.0
          prop :embedded, T.nilable(Embedded), name: "embedded"

          # @since 0.1.0
          prop :plugins, T.nilable(Plugins), name: "plugins"

          # @since 0.1.0
          sig {params(hash: T.untyped, strict: T.untyped).returns(EditorConfig)}
          def self.from_hash(hash, strict = nil)
            super(hash, strict)
          end
        end

        # @since 0.1.0
        prop :document_type, T.nilable(DocumentType), name: "documentType"

        # @since 0.1.0
        prop :height, T.nilable(String), name: "height"

        # @since 0.1.0
        prop :token, T.nilable(String), name: "token"

        # @since 0.1.0
        prop :type, T.nilable(Type), name: "type"

        # @since 0.1.0
        prop :width, T.nilable(String), name: "width"

        # @since 0.1.0
        prop :document, T.nilable(Document), name: "document"

        # @since 0.1.0
        prop :editor_config, T.nilable(EditorConfig), name: "editorConfig"

        # @since 0.1.0
        sig {params(hash: T.untyped, strict: T.untyped).returns(Config)}
        def self.from_hash(hash, strict = nil)
          super(hash, strict)
        end
      end
    end
  end
end
