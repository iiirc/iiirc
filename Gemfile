source 'https://rubygems.org'

gem 'rails', '4.0.0.beta1'

gem 'mysql2'
gem 'omniauth-github'
gem 'turbolinks'
gem 'octokit', '1.21.0'
gem 'rails_config'
gem 'gravtastic'
gem 'verification', github: 'banyan/verification', branch: 'relax-dependency'
gem 'rinku'

group :assets do
  gem 'sass-rails',   github: 'rails/sass-rails'
  gem 'coffee-rails', github: 'rails/coffee-rails'
  gem 'jquery-rails'
  gem 'uglifier',     '>= 1.0.3'
end

gem 'jquery-rails'

group :development do
  gem 'awesome_print'
  gem 'pry-rails'
  gem 'wirb'
  gem 'hirb-unicode'
  gem 'sqlite3'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'fuubar'
  gem 'fabrication'
  gem 'timecop'
  gem 'faker'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'launchy'
  gem 'rb-fsevent', '~> 0.9.1'
  gem 'growl' if system('which growlnotify >/dev/null')
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'shoulda'
  gem 'guard-livereload'
  gem 'tapp'
end
