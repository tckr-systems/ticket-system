source "https://rubygems.org"

ruby ">= 3.2.0"

# Devise-free, database-free core
gem "rails", "~> 8.0.0"
gem "mongoid", "~> 9.0"

# BigDecimals live in the standard library in newer rubies
gem "bigdecimal"

# Asset pipeline / bundling
gem "propshaft"
gem "importmap-rails"

# Hotwire (Turbo 8 + Stimulus)
gem "turbo-rails", "~> 2.0"
gem "stimulus-rails", "~> 1.3"

# Tailwind CSS pipeline (Rails-native: runs tailwindcss-ruby CLI in-process)
gem "tailwindcss-rails", "~> 3.3"

# Server + boot speed
gem "puma", ">= 5.0"
gem "bootsnap", ">= 1.4.4", require: false
gem "tzinfo-data", platforms: %i[windows jruby]

group :development do
  gem "web-console"
end