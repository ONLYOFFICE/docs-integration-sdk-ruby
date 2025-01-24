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
        # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/)
        #
        # @since 0.1.0
        class ConversionService < Service
          include ConversionServing

          # Error is an enum that represents the possible errors that can occur
          # when using the conversion service.
          #
          # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/error-codes/)
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
              end
            end
          end

          # Request is a class that represents the request options for the
          # conversion service.
          #
          # @since 0.1.0
          class Request < T::Struct
            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#delimiter)
            #
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

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#documentlayout)
            #
            # @since 0.1.0
            class DocumentLayout < T::Struct
              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#documentlayoutdrawplaceholders)
              #
              # @since 0.1.0
              prop :draw_place_holders, T.nilable(T::Boolean), name: "drawPlaceHolders"

              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#documentlayoutdrawformhighlight)
              #
              # @since 0.1.0
              prop :draw_form_highlight, T.nilable(T::Boolean), name: "drawFormHighlight"

              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#documentlayoutisprint)
              #
              # @since 0.1.0
              prop :is_print, T.nilable(T::Boolean), name: "isPrint"
            end

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#documentrenderer)
            #
            # @since 0.1.0
            class DocumentRenderer < T::Struct
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

              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#documentrenderertextassociation)
              #
              # @since 0.1.0
              prop :text_association, T.nilable(TextAssociation), name: "textAssociation"
            end

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#pdf)
            #
            # @since 0.1.0
            class Pdf < T::Struct
              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#pdfform)
              #
              # @since 0.1.0
              prop :form, T.nilable(T::Boolean), name: "form"
            end

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#spreadsheetlayout)
            #
            # @since 0.1.0
            class SpreadsheetLayout < T::Struct
              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#spreadsheetlayoutmargins)
              #
              # @since 0.1.0
              class Margins < T::Struct
                # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#spreadsheetlayoutmarginsbottom)
                #
                # @since 0.1.0
                prop :bottom, T.nilable(String), name: "bottom"

                # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#spreadsheetlayoutmarginsleft)
                #
                # @since 0.1.0
                prop :left, T.nilable(String), name: "left"

                # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#spreadsheetlayoutmarginsright)
                #
                # @since 0.1.0
                prop :right, T.nilable(String), name: "right"

                # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#spreadsheetlayoutmarginstop)
                #
                # @since 0.1.0
                prop :top, T.nilable(String), name: "top"
              end

              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#spreadsheetlayoutorientation)
              #
              # @since 0.1.0
              class Orientation < T::Enum
                enums do
                  # @since 0.1.0
                  Landscape = new("landscape")

                  # @since 0.1.0
                  Portrait = new("portrait")
                end
              end

              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#spreadsheetlayoutpagesize)
              #
              # @since 0.1.0
              class PageSize < T::Struct
                # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#spreadsheetlayoutpagesizeheight)
                #
                # @since 0.1.0
                prop :height, T.nilable(String), name: "height"

                # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#spreadsheetlayoutpagesizewidth)
                #
                # @since 0.1.0
                prop :width, T.nilable(String), name: "width"
              end

              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#spreadsheetlayoutfittoheight)
              #
              # @since 0.1.0
              prop :fit_to_height, T.nilable(Integer), name: "fitToHeight"

              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#spreadsheetlayoutfittowidth)
              #
              # @since 0.1.0
              prop :fit_to_width, T.nilable(Integer), name: "fitToWidth"

              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#spreadsheetlayoutgridlines)
              #
              # @since 0.1.0
              prop :grid_lines, T.nilable(T::Boolean), name: "gridLines"

              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#spreadsheetlayoutheadings)
              #
              # @since 0.1.0
              prop :headings, T.nilable(T::Boolean), name: "headings"

              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#spreadsheetlayoutignoreprintarea)
              #
              # @since 0.1.0
              prop :ignore_print_area, T.nilable(T::Boolean), name: "ignorePrintArea"

              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#spreadsheetlayoutmargins)
              #
              # @since 0.1.0
              prop :margins, T.nilable(Margins), name: "margins"

              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#spreadsheetlayoutorientation)
              #
              # @since 0.1.0
              prop :orientation, T.nilable(Orientation), name: "orientation"

              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#spreadsheetlayoutpagesize)
              #
              # @since 0.1.0
              prop :page_size, T.nilable(PageSize), name: "pageSize"

              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#spreadsheetlayoutscale)
              #
              # @since 0.1.0
              prop :scale, T.nilable(Integer), name: "scale"
            end

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#thumbnail)
            #
            # @since 0.1.0
            class Thumbnail < T::Struct
              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#thumbnailaspect)
              #
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

              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#thumbnailaspect)
              #
              # @since 0.1.0
              prop :aspect, T.nilable(Aspect), name: "aspect"

              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#thumbnailfirst)
              #
              # @since 0.1.0
              prop :first, T.nilable(T::Boolean), name: "first"

              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#thumbnailheight)
              #
              # @since 0.1.0
              prop :height, T.nilable(Integer), name: "height"

              # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#thumbnailwidth)
              #
              # @since 0.1.0
              prop :width, T.nilable(Integer), name: "width"
            end

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#watermark)
            #
            # @since 0.1.0
            class Watermark < T::Struct
              # todo
            end

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#async)
            #
            # @since 0.1.0
            prop :async, T.nilable(T::Boolean), name: "async"

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#codepage)
            #
            # @since 0.1.0
            prop :code_page, T.nilable(Integer), name: "codePage"

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#delimiter)
            #
            # @since 0.1.0
            prop :delimiter, T.nilable(Delimiter), name: "delimiter"

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#documentlayout)
            #
            # @since 0.1.0
            prop :document_layout, T.nilable(DocumentLayout), name: "documentLayout"

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#documentrenderer)
            #
            # @since 0.1.0
            prop :document_renderer, T.nilable(DocumentRenderer), name: "documentRenderer"

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#filetype)
            #
            # @since 0.1.0
            prop :filetype, T.nilable(String), name: "filetype"

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#key)
            #
            # @since 0.1.0
            prop :key, T.nilable(String), name: "key"

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#outputtype)
            #
            # @since 0.1.0
            prop :outputtype, T.nilable(String), name: "outputtype"

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#password)
            #
            # @since 0.1.0
            prop :password, T.nilable(String), name: "password"

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#pdf)
            #
            # @since 0.1.0
            prop :pdf, T.nilable(Pdf), name: "pdf"

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#region)
            #
            # @since 0.1.0
            prop :region, T.nilable(String), name: "region"

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#spreadsheetlayout)
            #
            # @since 0.1.0
            prop :spreadsheet_layout, T.nilable(SpreadsheetLayout), name: "spreadsheetLayout"

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#thumbnail)
            #
            # @since 0.1.0
            prop :thumbnail, T.nilable(Thumbnail), name: "thumbnail"

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#title)
            #
            # @since 0.1.0
            prop :title, T.nilable(String), name: "title"

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#url)
            #
            # @since 0.1.0
            prop :url, T.nilable(String), name: "url"

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/request/#watermark)
            #
            # @since 0.1.0
            prop :watermark, T.nilable(Watermark), name: "watermark"
          end

          # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/response/)
          #
          # @since 0.1.0
          class Result < T::Struct
            extend T::Sig

            # @since 0.1.0
            sig {params(hash: T.untyped, strict: T.untyped).returns(Result)}
            def self.from_hash(hash, strict = nil)
              super(hash, strict)
            end

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/response/#endconvert)
            #
            # @since 0.1.0
            prop :end_convert, T.nilable(T::Boolean), name: "endConvert"

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/response/#filetype)
            #
            # @since 0.1.0
            prop :file_type, T.nilable(String), name: "fileType"

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/response/#fileurl)
            #
            # @since 0.1.0
            prop :file_url, T.nilable(String), name: "fileUrl"

            # [ONLYOFFICE Reference](https://api.onlyoffice.com/docs/docs-api/additional-api/conversion-api/response/#percent)
            #
            # @since 0.1.0
            prop :percent, T.nilable(Integer), name: "percent"
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
