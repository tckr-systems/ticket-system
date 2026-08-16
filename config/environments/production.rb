require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # Assume all access to the app is happening through a SSL-terminating reverse proxy.
  # Can be used together with `config.force_ssl = true` to guard against "host header" attacks.
  # See https://guides.rubyonrails.org/configuring.html#config-action-dispatch-default-headers
  config.action_dispatch.default_headers = {
    "X-Frame-Options" => "SAMEORIGIN",
    "X-XSS-Protection" => "0",
    "X-Content-Type-Options" => "nosniff",
    "X-Permitted-Cross-Domain-Policies" => "none",
    "Referrer-Policy" => "strict-origin-when-cross-origin"
  }

  # Enable compression.
  config.assets.compress = true

  # Specifies the logger that will be used to create the system log on any portion
  # of the system. Using the Rails logger is recommended so the event logging
  # can still be performed even when the ActiveRecord transaction is rolled back.
  config.logger = ActiveSupport::Logger.new(STDOUT)
    .tap { |logger| logger.formatter = ::Logger::Formatter.new }
    .then { |logger| ActiveSupport::TaggedLogging.new(logger) }
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Use a real queuing backend for Active Job (and separate queues per environment).
  # config.active_job.queue_adapter = :resque

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Don't log any deprecations.
  config.active_support.report_deprecations = false
end