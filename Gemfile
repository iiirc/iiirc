source 'https://rubygems.org'

gem 'rails', '3.2.11'

gem 'mysql2'
gem 'omniauth-github'
gem 'turbolinks'
gem 'rails_config'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :development do
  gem "tapp"
  gem "awesome_print"
  gem "wirb"
  gem "hirb-unicode"
end

group :development, :test do
  gem "rspec-rails"
  gem "fabrication", github: 'paulelliott/fabrication'
  gem "timecop"
  gem "faker"
  gem "database_cleaner"
  gem "capybara"
  gem "capybara-webkit"
  gem "launchy"
  gem "quiet_assets", github: "evrone/quiet_assets"
  gem 'rb-fsevent', '~> 0.9.1'
  gem "growl" if system('which growlnotify >/dev/null')
  gem "guard-spork"
  gem "guard-rspec"
  gem 'guard-livereload'
end
