#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Iiirc::Application.load_tasks

desc 'setup files for development'
task 'setup' do
  %x{cp config/database.sample.yml config/database.yml}

  %w(test development).each do |env|
    %x{cp config/settings/environment.sample.yml config/settings/#{env}.yml}
  end

  %x{echo "Iiirc::Application.config.secret_key_base = '`bundle exec rake secret`'" > config/initializers/secret_token.rb}
end
