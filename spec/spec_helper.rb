# frozen_string_literal: true

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/spec/'
  add_filter '/config/'
  minimum_coverage 5 # TODO: increase to 90
end

ENV['RAILS_ENV'] ||= 'test'

require 'bundler/setup'

# Load Rails dependencies
require 'rails'
require 'action_controller'
require 'action_view'
require 'active_support/all'

# Load ViewComponent and test helpers
require 'view_component'
require 'view_component/test_helpers'
require 'capybara/rspec'

# Load the gem
require 'pathogen/view_components/engine'

# Initialize a minimal Rails application for testing
module TestApp
  class Application < Rails::Application
    config.root = File.dirname(__FILE__)
    config.secret_key_base = 'test_secret_key_base_minimum_30_characters_long'
    config.eager_load = false
    config.logger = Logger.new(nil)
    config.active_support.deprecation = :stderr
    config.active_support.to_time_preserves_timezone = :zone

    # Add component view paths for partial resolution
    config.view_paths = [
      Rails.root.join('app/components'),
      Rails.root.join('app/views')
    ]
  end
end

TestApp::Application.initialize!

# Configure view paths for partial resolution in tests
TestApp::Application.config.view_paths = [
  Rails.root.join('app/components'),
  Rails.root.join('app/views')
]

# Load support files
Dir[File.expand_path('support/**/*.rb', __dir__)].each { |f| require f }

# Configure Capybara for ViewComponent testing
Capybara.app = TestApp::Application

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Include ViewComponent test helpers
  config.include ViewComponent::TestHelpers, type: :component
  config.include Capybara::RSpecMatchers, type: :component

  # Filter backtrace to exclude gem paths
  config.filter_run_when_matching :focus
  config.run_all_when_everything_filtered = true

  # Use color in STDOUT
  config.color = true

  # Use the specified formatter
  config.formatter = :documentation

  # Randomize test order
  config.order = :random
  Kernel.srand config.seed
end
