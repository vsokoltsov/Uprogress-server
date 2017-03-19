# frozen_string_literal: true
namespace :deploy do
  desc 'Deploy application'
  task production: :environment do
    # rubocop:disable Rails/FilePath
    exec "/bin/bash #{Rails.root.join('config', 'docker', 'deploy.sh')}"
  end
end
