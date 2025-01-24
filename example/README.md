# Example

This example demonstrates how to integrate the ONLYOFFICE Document Server with Ruby applications using the ONLYOFFICE Docs Integration Ruby SDK. The example shows how to set up a web server that converts DOCX files to PDF format.

## Prerequisites

Before starting, ensure you have the following installed:

- [Git]
- [Make]
- [Docker]

## Installation

Clone the Git repository from the company's Git server:

```sh
git clone git@git.onlyoffice.com:onlyoffice/docs-integration-sdk-ruby.git
```

... or from the GitHub mirror:

```sh
git clone git@github.com:onlyoffice/docs-integration-sdk-ruby.git
```

Navigate to the project directory:

```sh
cd docs-integration-sdk-ruby
```

Build the Docker image:

```sh
make image
```

## Running the Example

Navigate to the example directory:

```sh
cd example
```

Start the Docker containers:

```sh
docker compose up --build
```

## Testing the Integration

Verify Document Server health by opening the following URL in your browser:

http://localhost:8080/healthcheck

Download a sample file by opening the following URL in your browser:

http://localhost:8080/download

Convert the downloaded file to PDF by opening the following URL in your browser:

http://localhost:8080/convert

View the converted file by opening the following URL in your browser:

http://localhost:8080/result.pdf

<!-- Footnotes -->

[Git]: https://git-scm.com/
[Make]: https://gnu.org/software/make/
[Docker]: https://docker.com/
