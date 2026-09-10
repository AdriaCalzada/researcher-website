FROM ruby:3.3-bookworm

# Dependencias típicas para gems nativas + runtime JS para ExecJS (coffee-script, etc.)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    pkg-config \
    git \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /srv/jekyll

# Match the Bundler version recorded in Gemfile.lock.
RUN gem install bundler -v 2.7.2 --no-document
