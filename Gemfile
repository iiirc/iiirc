source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

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
