source 'https://rubygems.org'
ruby '2.3.1'

gem 'rails', '~> 4.0.4'

gem 'mysql2', '~> 0.3.21'
gem 'omniauth-github'
gem 'turbolinks'
gem 'octokit', '~> 1'
gem 'rails_config', '~> 0.3.3'
gem 'gravtastic'
gem 'verification', github: 'sikachu/verification'
gem 'rinku'
gem 'friendly_id'
gem 'twitter'
gem 'kaminari'
gem 'newrelic_rpm'
gem 'draper'
gem 'faraday'
gem 'slim-rails'

gem 'sass-rails',   '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier',     '>= 1.3.0'
gem 'jquery-rails'
gem 'tophat'

gem 'json', '~> 1.8.1'

group :development do
  gem 'awesome_print'
  gem 'wirb'
  gem 'hirb-unicode'
  gem 'pry'
  gem 'pry-rails'
  # gem 'pry-debugger'
  gem 'pry-doc'
  gem 'sqlite3'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.6.0'
  gem 'rspec-core', '~> 3.6.0'
  gem 'rspec-mocks', '~> 3.6.0'
  gem 'rspec-support', '~> 3.6.0'
  gem 'mocha', require: 'mocha/api'
  gem 'fabrication'
  gem 'timecop'
  gem 'faker'
  gem 'database_cleaner'
  gem 'capybara', git: 'https://github.com/jnicklas/capybara.git'
  gem 'poltergeist'
  gem 'launchy'
  # gem 'rb-fsevent', '~> 0.9.1'
  # gem 'guard-spork'
  # gem 'guard-rspec'
  gem 'shoulda'
  # gem 'guard-livereload'
  gem 'tapp'
end

group :test do
  gem 'simplecov', require: false
  gem 'coveralls', require: false
  gem 'test-unit', require: 'test/unit'
end

group :production do
  gem 'rails_12factor'
  gem 'rack-google-analytics'
  gem "unicorn"
  # gem 'remote_syslog_logger'
end
