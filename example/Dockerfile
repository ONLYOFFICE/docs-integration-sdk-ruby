FROM ruby:3.3.7-alpine3.21
WORKDIR /srv
COPY --from=onlyoffice-docs_integration_sdk *.gem .
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
COPY main.rb main.rb
COPY Makefile Makefile
RUN \
	apk add --no-cache --update make && \
	gem install *.gem && \
	make prod
CMD ["ruby", "main.rb"]
