# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

gem 'rails', '>= 8'

# development dependencies
group :development do
  gem 'annotate'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rails-accessibility', '~> 1.0'
end

# test dependencies
group :test do
  gem 'capybara'
  gem 'rspec-rails'
  gem 'simplecov', require: false
end

# development and test dependencies
group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
end
