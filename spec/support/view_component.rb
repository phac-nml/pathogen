# frozen_string_literal: true

require 'view_component/test_helpers'

# Define a minimal controller for ViewComponent testing
class ApplicationController < ActionController::Base
end

RSpec.configure do |config|
  config.include ViewComponent::TestHelpers, type: :component
  config.include Capybara::RSpecMatchers, type: :component

  # Set up a test controller for each component test
  config.before(:each, type: :component) do
    @controller = ApplicationController.new
  end
end
