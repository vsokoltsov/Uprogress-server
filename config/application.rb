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
    config.console.whitelisted_ips = '192.168.99.1'

    config.middleware.use 'OliveBranch::Middleware'

    config.active_record.raise_in_transactional_callbacks = true
    config.middleware.insert_before 0, 'Rack::Cors' do
      allow do
        origins 'localhost:9000'
        resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete]
      end
    end

    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exist?(env_file)
    end
  end
end
