FROM ruby:3.3-bookworm

# Dependencias típicas para gems nativas + runtime JS para ExecJS (coffee-script, etc.)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    pkg-config \
    git \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /srv/jekyll

# Bundler estable (evita sorpresas)
RUN gem update --system && gem install bundler -v 2.7.2
