require "active_support/core_ext/integer/time"

# The test environment is used exclusively to run your application's test suite.
Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # While tests run files are not watched, reloading is not necessary.
  config.enable_reloading = false

  # Eager loading loads your entire application. When running a single test locally,
  # this is usually not necessary, and can slow down your test suite.
  config.eager_load = ENV["CI"].present?

  # Show full error reports and disable caching.
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.cache_store = :null_store

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr
end