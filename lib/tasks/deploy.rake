# frozen_string_literal: true
namespace :deploy do
  desc 'Deploy application'
  task production: :environment do
    exec "/bin/bash #{Rails.root}/config/docker/deploy.sh"
  end
end
