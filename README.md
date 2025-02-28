# ONLYOFFICE Docs Integration Ruby SDK

ONLYOFFICE Docs Integration Ruby SDK provides common interfaces and default implementations for integrating ONLYOFFICE Document Server into your own website or application on Ruby.

## Installation

Use the `gem` command to install the SDK:

```sh
gem install onlyoffice-docs_integration_sdk
```

... or add the following line to your `Gemfile`:

```ruby
gem "onlyoffice-docs_integration_sdk"
```

... and run:

```sh
bundle install
```

After that you can use the SDK in your Ruby code:

```ruby
require "onlyoffice/docs_integration_sdk"
```

## Usage

Navigate to the [example] directory for a basic SDK usage. Visit [GitHub Pages] for documentation.

## Compatibility

This SDK is developed on Ruby version 3. However, the [test suite] is also run for Ruby version 2. We will try to maintain compatibility with version 2 as much as possible. When support for compatibility with version 2 is discontinued, the major version of the library will be increased.

## License

This SDK is distributed under the Apache-2.0 license found in the [LICENSE] file.

<!-- Footnotes -->

[example]: https://github.com/onlyoffice/docs-integration-sdk-ruby/blob/master/example/
[GitHub Pages]: https://onlyoffice.github.io/docs-integration-sdk-ruby/
[LICENSE]: https://github.com/onlyoffice/docs-integration-sdk-ruby/blob/master/LICENSE/
[test suite]: https://github.com/onlyoffice/docs-integration-sdk-ruby/blob/master/.github/workflows/audit.yml
