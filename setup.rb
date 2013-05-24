#!/usr/bin/env ruby

%x{cp config/database.sample.yml config/database.yml}

%w(test development).each do |env|
  %x{cp config/settings/environment.sample.yml config/settings/#{env}.yml}
end

%x{echo "Iiirc::Application.config.secret_key_base = '`bundle exec rake secret`'" > config/initializers/secret_token.rb}
