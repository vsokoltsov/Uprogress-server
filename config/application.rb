# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UprogressServer
  class Application < Rails::Application
    config.api_only = true

    config.middleware.use 'OliveBranch::Middleware'
    config.web_console.whiny_requests = false
    config.active_record.raise_in_transactional_callbacks = true
    config.active_job.queue_adapter = :sidekiq
    config.middleware.insert_before 0, 'Rack::Cors' do
      allow do
        origins '*'
        resource '*', headers: :any, methods: %i[get post put patch delete options]
      end
    end

    config.before_configuration do
      env_file = Rails.root.join('config', 'local_env.yml')
      if File.exist?(env_file)
        YAML.safe_load(File.open(env_file)).each do |key, value|
          ENV[key.to_s] = value
        end
      end
    end
  end
end
