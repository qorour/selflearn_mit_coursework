require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ProjectoneWebanalytics
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Enabling CORS, allowing specific domains to bypass SOP (Same origin policy, essentially security from diff domain)
    # AKA, allowing the browser to send cross-origin requests by adding CORS (cross-origin resource sharing) headers to responses.

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'  # Allows all origins
        resource '*', # and all its resources to access
          headers: :any, # and all that resources content (for now)
          methods: [:get, :post, :put, :delete, :options]
      end
    end
  end
end
