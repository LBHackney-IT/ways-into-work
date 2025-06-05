FROM ruby:2.6.6

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update -qq && apt-get install -qq --no-install-recommends \
    nodejs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install --jobs=4

WORKDIR /app
COPY Gemfile Gemfile.lock ./

ENV RAILS_ENV ${RAILS_ENV}

RUN gem install bundler:1.17.3
RUN bundle check || bundle install

RUN RAILS_ENV=production SECRET_KEY_BASE="secret" rails assets:precompile

# Add a script to be executed every time the container starts.
COPY bin/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

COPY . /app
EXPOSE 3001

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3001"]