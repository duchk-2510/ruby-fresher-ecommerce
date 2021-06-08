require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RubyFresherEcommerce
  class Application < Rails::Application
    config.load_defaults 6.1
    config.time_zone = "Hanoi"
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}')]
    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :vi
    config.active_job.queue_adapter = :sidekiq
  end
end

