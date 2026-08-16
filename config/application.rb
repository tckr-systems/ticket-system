require_relative "boot"

require "rails"
# Pick the frameworks we want. No Active Record, no SQLite, no Postgres —
# persistence is handled by Mongoid -> MongoDB.
%w[
  active_job
  active_model
  active_support
  action_controller
  action_mailer
  action_view
].each do |framework|
  require "#{framework}/railtie"
end
# Rails' API template requires the engine, not a railtie, for Action Cable.
require "action_cable/engine"

Bundler.require(*Rails.groups)

module TicketSystem
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    config.time_zone = "UTC"

    # Use Mongoid (MongoDB) as the ORM/generator backend by default.
    config.generators do |g|
      g.orm :mongoid
      g.template_engine :erb
      g.test_framework false
      g.helper false
      g.assets false
      g.system_tests false
    end
  end
end