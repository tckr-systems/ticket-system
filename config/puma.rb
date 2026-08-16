# This file is used by Rack-based servers to start the application (e.g. Puma).

# A worker-based model is not used in this app.
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# Use a local socket or a TCP port.
port        ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RAILS_ENV") { ENV.fetch("RACK_ENV", "development") }
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Allow puma to be restarted by the `rails restart` command.
plugin :tmp_restart