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

require_relative "lib/onlyoffice/docs_integration_sdk/version"

Gem::Specification.new do |s|
  s.name    = "onlyoffice-docs_integration_sdk"
  s.version = Onlyoffice::DocsIntegrationSdk::VERSION
  s.authors = ["Ascensio System SIA"]
  s.email   = ["integration@onlyoffice.com"]

  s.summary     = "ONLYOFFICE Docs Integration SDK"
  s.description = "ONLYOFFICE Docs Integration Ruby SDK provides common interfaces and default implementations for integrating ONLYOFFICE Document Server into your own website or application on Ruby."
  s.homepage    = "https://github.com/onlyoffice/docs-integration-sdk-ruby/"
  s.license     = "Apache-2.0"

  s.metadata = {
    "bug_tracker_uri"   => "https://github.com/onlyoffice/docs-integration-sdk-ruby/issues/",
    "changelog_uri"     => "https://github.com/onlyoffice/docs-integration-sdk-ruby/blob/master/CHANGELOG.md/",
    "documentation_uri" => "https://onlyoffice.github.io/docs-integration-sdk-ruby/",
    "source_code_uri"   => "https://github.com/onlyoffice/docs-integration-sdk-ruby/",
  }

  s.files = []
  s.test_files = []
  s.require_paths = ["lib"]

  for f in Dir.glob("lib/**/*.rb")
    if f.end_with?("_test.rb")
      s.test_files.push(f)
    else
      s.files.push(f)
    end
  end

  s.required_ruby_version = ">= 2.7.0"

  s.add_dependency("jwt", "2.10.1")
  s.add_dependency("sorbet-runtime", "0.5.11766")

  s.add_development_dependency("rake", "13.2.1")
  s.add_development_dependency("rdoc", "6.11.0")
  s.add_development_dependency("rubocop", "1.70.0")
  s.add_development_dependency("rubocop-rake", "0.6.0")
  s.add_development_dependency("rubocop-sorbet", "0.8.0")
  s.add_development_dependency("simplecov", "0.22.0")
  s.add_development_dependency("sorbet", "0.5.11766")
  s.add_development_dependency("tapioca", "0.11.8")
  s.add_development_dependency("test-unit", "3.6.7")
  s.add_development_dependency("webrick", "1.9.1")
  s.add_development_dependency("yard", "0.9.37")
  s.add_development_dependency("yard-sorbet", "0.8.1")
end
