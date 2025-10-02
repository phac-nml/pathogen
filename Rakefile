# frozen_string_literal: true

# rubocop:disable Rails/RakeEnvironment
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

# Default task: run tests and linting
desc 'Run tests and linting'
task default: %i[spec rubocop]

# RSpec test task
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rspec_opts = '--format documentation --color'
end

# RuboCop linting task
RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = ['--display-cop-names']
end

# Auto-correct RuboCop violations
desc 'Auto-correct RuboCop violations'
task :rubocop_autocorrect do
  sh 'bundle exec rubocop -A'
end

# Build the gem
desc 'Build the gem'
task :build do
  sh 'gem build pathogen_view_components.gemspec'
end

# Install the gem locally
desc 'Install the gem locally'
task install: :build do
  version = File.read('lib/pathogen/view_components/version.rb')[/STRING = ['"](.+)['"]/, 1]
  sh "gem install pathogen_view_components-#{version}.gem"
end

# Clean build artifacts
desc 'Clean build artifacts'
task :clean do
  sh 'rm -f *.gem'
end

# Release task (requires rubygems credentials)
desc 'Release the gem to RubyGems.org'
task release: %i[spec rubocop build] do
  sh 'gem push *.gem'
end

# rubocop:enable Rails/RakeEnvironment
