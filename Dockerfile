FROM ruby:3.2.2-slim

ARG UID=1001
ARG GID=1001

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      build-essential \
      ca-certificates \
      git \
      libpq-dev \
      libyaml-dev \
      postgresql-client && \
    rm -rf /var/lib/apt/lists/* && \
    gem install bundler:2.5.23 && \
    groupadd --gid ${GID} app && \
    useradd --uid ${UID} --gid app --create-home app

WORKDIR /app

COPY Gemfile Gemfile.lock* ./
RUN bundle install && chown -R app:app /usr/local/bundle

COPY . .
RUN chmod +x bin/docker-entrypoint && chown -R app:app /app

USER app

ENTRYPOINT ["./bin/docker-entrypoint"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
