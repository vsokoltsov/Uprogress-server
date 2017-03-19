# frozen_string_literal: true
namespace :deploy do
  desc 'Deploy application'
  task production: :environment do
    path = Rails.root.join('config', 'docker', 'deploy.sh')
    exec "/bin/bash #{path}"
  end
end
