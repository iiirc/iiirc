# coding: utf-8
require 'rubygems'
require 'rss'

unless ENV['COVERAGE'] == 'off'
  puts 'Run with `COVERAGE=off` if you do not want to generate simplecov coverage reports.'
  require 'simplecov'
  # Settings for coveralls: https://coveralls.io/r/iiirc/iiirc
  require 'coveralls'
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]
  SimpleCov.start 'rails'
end

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rails'
require 'capybara/poltergeist'
require 'omniauth'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include Capybara::DSL
  OmniAuth.config.test_mode = true

  config.infer_base_class_for_anonymous_controllers = true
  config.order = "random"
  config.raise_errors_for_deprecations!

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

Capybara.javascript_driver = :poltergeist
