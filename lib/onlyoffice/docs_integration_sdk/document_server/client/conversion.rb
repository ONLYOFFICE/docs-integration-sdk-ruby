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
        # ConversionServing is an interface that describes the methods that must
        # be implemented to be considered a conversion service.
        #
        # @since 0.1.0
        module ConversionServing
          extend T::Sig
          extend T::Helpers
          interface!

          # @param r The request options.
          # @return A tuple containing the result and the response.
          sig {abstract.params(r: ConversionService::Request).returns([ConversionService::Result, Response])}
          def do(r); end
        end

        # ConversionService is an implementation of the {ConversionServing}
        # interface.
        #
        # @since 0.1.0
        class ConversionService < Service
          include ConversionServing

          # Error is an enum that represents the possible errors that can occur
          # when using the conversion service.
          #
          # @since 0.1.0
          class Error < T::Enum
            extend T::Sig

            enums do
              # @since 0.1.0
              UnknownError = new(-1)

              # @since 0.1.0
              ConversionTimeout = new(-2)

              # @since 0.1.0
              ConversionError = new(-3)

              # @since 0.1.0
              DownloadError = new(-4)

              # @since 0.1.0
              IncorrectPassword = new(-5)

              # @since 0.1.0
              DatabaseError = new(-6)

              # @since 0.1.0
              InputError = new(-7)

              # @since 0.1.0
              InvalidToken = new(-8)

              # @since 0.1.0
              UnknownFormat = new(-9)

              # @since 0.1.0
              SizeLimitExceeded = new(-10)
            end

            # description returns the human-readable description of the error.
            #
            # @since 0.1.0
            sig {returns(String)}
            def description
              case self
              when UnknownError
                "Unknown error"
              when ConversionTimeout
                "Conversion timeout error"
              when ConversionError
                "Conversion error"
              when DownloadError
                "Error while downloading the document file to be converted"
              when IncorrectPassword
                "Incorrect password"
              when DatabaseError
                "Error while accessing the conversion result database"
              when InputError
                "Input error"
              when InvalidToken
                "Invalid token"
              when UnknownFormat
                "The converter cannot automatically determine the output file format"
              when SizeLimitExceeded
                "Size limit exceeded"
              else
                # :nocov:
                # unreachable
                # :nocov:
              end
            end
          end

          # Request is a class that represents the request options for the
          # conversion service.
          #
          # @since 0.1.0
          class Request < T::Struct
            extend T::Sig

            # @since 0.1.0
            class Delimiter < T::Enum
              enums do
                # @since 0.1.0
                None = new(0)

                # @since 0.1.0
                Tab = new(1)

                # @since 0.1.0
                Semicolon = new(2)

                # @since 0.1.0
                Colon = new(3)

                # @since 0.1.0
                Comma = new(4)

                # @since 0.1.0
                Space = new(5)
              end
            end

            # @since 0.1.0
            class DocumentLayout < T::Struct
              extend T::Sig

              # @since 0.1.0
              prop :draw_place_holders, T.nilable(T::Boolean), name: "drawPlaceHolders"

              # @since 0.1.0
              prop :draw_form_highlight, T.nilable(T::Boolean), name: "drawFormHighlight"

              # @since 0.1.0
              prop :is_print, T.nilable(T::Boolean), name: "isPrint"

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(DocumentLayout)}
              def self.from_hash(hash, strict = nil)
                super(hash, strict)
              end
            end

            # @since 0.1.0
            class DocumentRenderer < T::Struct
              extend T::Sig

              # @since 0.1.0
              class TextAssociation < T::Enum
                enums do
                  # @since 0.1.0
                  BlockChar = new("blockChar")

                  # @since 0.1.0
                  BlockLine = new("blockLine")

                  # @since 0.1.0
                  PlainLine = new("plainLine")

                  # @since 0.1.0
                  PlainParagraph = new("plainParagraph")
                end
              end

              # @since 0.1.0
              prop :text_association, T.nilable(TextAssociation), name: "textAssociation"

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(DocumentRenderer)}
              def self.from_hash(hash, strict = nil)
                super(hash, strict)
              end
            end

            # @since 0.1.0
            class Pdf < T::Struct
              extend T::Sig

              # @since 0.1.0
              prop :form, T.nilable(T::Boolean), name: "form"

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(Pdf)}
              def self.from_hash(hash, strict = nil)
                super(hash, strict)
              end
            end

            # @since 0.1.0
            class SpreadsheetLayout < T::Struct
              extend T::Sig

              # @since 0.1.0
              class Margins < T::Struct
                extend T::Sig

                # @since 0.1.0
                prop :bottom, T.nilable(String), name: "bottom"

                # @since 0.1.0
                prop :left, T.nilable(String), name: "left"

                # @since 0.1.0
                prop :right, T.nilable(String), name: "right"

                # @since 0.1.0
                prop :top, T.nilable(String), name: "top"

                # @since 0.1.0
                sig {params(hash: T.untyped, strict: T.untyped).returns(Margins)}
                def self.from_hash(hash, strict = nil)
                  super(hash, strict)
                end
              end

              # @since 0.1.0
              class Orientation < T::Enum
                enums do
                  # @since 0.1.0
                  Landscape = new("landscape")

                  # @since 0.1.0
                  Portrait = new("portrait")
                end
              end

              # @since 0.1.0
              class PageSize < T::Struct
                extend T::Sig

                # @since 0.1.0
                prop :height, T.nilable(String), name: "height"

                # @since 0.1.0
                prop :width, T.nilable(String), name: "width"

                # @since 0.1.0
                sig {params(hash: T.untyped, strict: T.untyped).returns(PageSize)}
                def self.from_hash(hash, strict = nil)
                  super(hash, strict)
                end
              end

              # @since 0.1.0
              prop :fit_to_height, T.nilable(Integer), name: "fitToHeight"

              # @since 0.1.0
              prop :fit_to_width, T.nilable(Integer), name: "fitToWidth"

              # @since 0.1.0
              prop :grid_lines, T.nilable(T::Boolean), name: "gridLines"

              # @since 0.1.0
              prop :headings, T.nilable(T::Boolean), name: "headings"

              # @since 0.1.0
              prop :ignore_print_area, T.nilable(T::Boolean), name: "ignorePrintArea"

              # @since 0.1.0
              prop :margins, T.nilable(Margins), name: "margins"

              # @since 0.1.0
              prop :orientation, T.nilable(Orientation), name: "orientation"

              # @since 0.1.0
              prop :page_size, T.nilable(PageSize), name: "pageSize"

              # @since 0.1.0
              prop :scale, T.nilable(Integer), name: "scale"

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(SpreadsheetLayout)}
              def self.from_hash(hash, strict = nil)
                super(hash, strict)
              end
            end

            # @since 0.1.0
            class Thumbnail < T::Struct
              extend T::Sig

              # @since 0.1.0
              class Aspect < T::Enum
                enums do
                  # @since 0.1.0
                  Stretch = new(0)

                  # @since 0.1.0
                  Keep = new(1)

                  # @since 0.1.0
                  Page = new(2)
                end
              end

              # @since 0.1.0
              prop :aspect, T.nilable(Aspect), name: "aspect"

              # @since 0.1.0
              prop :first, T.nilable(T::Boolean), name: "first"

              # @since 0.1.0
              prop :height, T.nilable(Integer), name: "height"

              # @since 0.1.0
              prop :width, T.nilable(Integer), name: "width"

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(Thumbnail)}
              def self.from_hash(hash, strict = nil)
                super(hash, strict)
              end
            end

            # @since 0.1.0
            class Watermark < T::Struct
              extend T::Sig

              # todo

              # @since 0.1.0
              sig {params(hash: T.untyped, strict: T.untyped).returns(Watermark)}
              def self.from_hash(hash, strict = nil)
                super(hash, strict)
              end
            end

            # @since 0.1.0
            prop :async, T.nilable(T::Boolean), name: "async"

            # @since 0.1.0
            prop :code_page, T.nilable(Integer), name: "codePage"

            # @since 0.1.0
            prop :delimiter, T.nilable(Delimiter), name: "delimiter"

            # @since 0.1.0
            prop :document_layout, T.nilable(DocumentLayout), name: "documentLayout"

            # @since 0.1.0
            prop :document_renderer, T.nilable(DocumentRenderer), name: "documentRenderer"

            # @since 0.1.0
            prop :filetype, T.nilable(String), name: "filetype"

            # @since 0.1.0
            prop :key, T.nilable(String), name: "key"

            # @since 0.1.0
            prop :outputtype, T.nilable(String), name: "outputtype"

            # @since 0.1.0
            prop :password, T.nilable(String), name: "password"

            # @since 0.1.0
            prop :pdf, T.nilable(Pdf), name: "pdf"

            # @since 0.1.0
            prop :region, T.nilable(String), name: "region"

            # @since 0.1.0
            prop :spreadsheet_layout, T.nilable(SpreadsheetLayout), name: "spreadsheetLayout"

            # @since 0.1.0
            prop :thumbnail, T.nilable(Thumbnail), name: "thumbnail"

            # @since 0.1.0
            prop :title, T.nilable(String), name: "title"

            # @since 0.1.0
            prop :url, T.nilable(String), name: "url"

            # @since 0.1.0
            prop :watermark, T.nilable(Watermark), name: "watermark"

            # @since 0.1.0
            sig {params(hash: T.untyped, strict: T.untyped).returns(Request)}
            def self.from_hash(hash, strict = nil)
              super(hash, strict)
            end
          end

          # @since 0.1.0
          class Result < T::Struct
            extend T::Sig

            # @since 0.1.0
            prop :end_convert, T.nilable(T::Boolean), name: "endConvert"

            # @since 0.1.0
            prop :file_type, T.nilable(String), name: "fileType"

            # @since 0.1.0
            prop :file_url, T.nilable(String), name: "fileUrl"

            # @since 0.1.0
            prop :percent, T.nilable(Integer), name: "percent"

            # @since 0.1.0
            sig {params(hash: T.untyped, strict: T.untyped).returns(Result)}
            def self.from_hash(hash, strict = nil)
              super(hash, strict)
            end
          end

          # do makes a request to the conversion service. It returns an empty
          # result if an error occurs.
          #
          # @param r The request options.
          # @return A tuple containing the result and the response.
          # @since 0.1.0
          sig {override.params(r: Request).returns([Result, Response])}
          def do(r)
            con, res = @client.post("ConvertService.ashx", r.serialize)
            if res.error
              return [Result.new, res]
            end

            err = T.let(nil, T.untyped)

            begin
              if con && con.is_a?(Hash) && con.key?("error")
                err = Error.from_serialized(con["error"])
              elsif con
                ret = Result.from_hash(con)
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
