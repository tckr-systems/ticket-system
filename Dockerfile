FROM ruby:3.3.7-slim AS build

WORKDIR /app

# Install runtime + compile deps (tailwindcss-ruby ships prebuilt binaries,
# but keep build-essential around for any native gem installs).
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
      build-essential \
      curl \
    && rm -rf /var/lib/apt/lists/*

# Install gems early so builds stay cached.
COPY Gemfile Gemfile.lock* ./
RUN gem install bundler && bundle install

# Compile the Tailwind stylesheet once at image build time.
COPY config/tailwind.config.js ./config/tailwind.config.js
COPY app ./app
COPY Rakefile config.ru ./
COPY config/application.rb config/boot.rb config/environment.rb ./config/
COPY config/environments ./config/environments
COPY config/importmap.rb config/puma.rb ./config/
COPY config/initializers ./config/initializers
RUN bundle exec rails tailwindcss:build

FROM ruby:3.3.7-slim

WORKDIR /app

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
      curl \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /app /app

ENV RAILS_ENV=production \
    RAILS_LOG_TO_STDOUT=true \
    RAILS_SERVE_STATIC_FILES=true \
    MONGODB_URI=mongodb://mongo:27017/ticket_system_production \
    SECRET_KEY_BASE=override-this-in-deploy

# Digest and copy all assets for production serving.
RUN bundle exec rails assets:precompile

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]