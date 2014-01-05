source 'https://rubygems.org'
ruby '2.1.0'

gem 'rails', '4.0.0'

gem 'mysql2'
gem 'omniauth-github'
gem 'turbolinks'
gem 'octokit', '1.21.0'
gem 'rails_config'
gem 'gravtastic'
gem 'verification', github: 'sikachu/verification'
gem 'rinku'
gem 'friendly_id', github: 'FriendlyId/friendly_id'
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
gem 'rails_12factor'

group :development do
  gem 'awesome_print'
  gem 'wirb'
  gem 'hirb-unicode'
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-debugger'
  gem 'pry-doc'
  gem 'sqlite3'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'rspec-rails', '3.0.0.beta1'
  # https://github.com/rspec/rspec-rails/issues/878#issuecomment-30575316
  gem 'rspec-core', git: 'https://github.com/rspec/rspec-core.git', branch: 'master'
  # https://github.com/rspec/rspec-mocks/pull/467
  gem 'rspec-mocks', git: 'https://github.com/rspec/rspec-mocks.git', branch: 'master'
  gem 'mocha', require: 'mocha/api'
  gem 'fabrication'
  gem 'timecop'
  gem 'faker'
  gem 'database_cleaner'
  gem 'capybara', '2.2.0'
  gem 'poltergeist'
  gem 'launchy'
  gem 'rb-fsevent', '~> 0.9.1'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'shoulda'
  gem 'guard-livereload'
  gem 'tapp'
end

group :test do
  gem 'simplecov', require: false
  gem 'coveralls', require: false
end

group :production do
  gem 'rack-google-analytics'
end
