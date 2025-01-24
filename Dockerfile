FROM ruby:3.3.7-alpine3.21 AS build
WORKDIR /srv
COPY lib lib
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
COPY Makefile Makefile
COPY *.gemspec .
RUN \
	apk add --no-cache --update make && \
	make prod && \
	make gem

FROM scratch
COPY --from=build /srv/*.gem .
