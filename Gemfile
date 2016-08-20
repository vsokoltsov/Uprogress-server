# frozen_string_literal: true
source 'https://rubygems.org'

gem 'rails', '4.2.5.2'
gem 'pg', '~> 0.15'

gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'active_model_serializers'
gem 'rack-cors', require: 'rack/cors'
gem 'pry-rails'
gem 'tainbox'
gem 'with_advisory_lock'
gem 'olive_branch'
gem 'unicorn'
gem 'jwt'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'faker', '~> 1.6.3'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'rubocop', require: false
end

group :test do
  gem 'launchy'
  gem 'database_cleaner', '~> 1.0.1'
  gem 'json_spec'
end
