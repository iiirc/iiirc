source 'https://rubygems.org'

gem 'rails', '3.2.11'

gem 'mysql2'
gem 'omniauth-github'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :development, :test do
  gem "tapp"
  gem "awesome_print"
end

group :development, :test do
  gem "wirb"
  gem "hirb-unicode"
  gem "quiet_assets"
  gem "pry-rails"
  gem "rspec-rails"
  gem "fabrication"
  gem "faker"
  gem "timecop"
  gem "capybara-webkit"
  gem "guard-spork"
  gem "guard-rspec"
  gem "growl" if system('which growlnotify >/dev/null')
end
