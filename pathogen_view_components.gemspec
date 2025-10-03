# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pathogen/view_components/version'

Gem::Specification.new do |spec|
  spec.name          = 'pathogen_view_components'
  spec.authors       = ['Bioinformatics, Public Health Agency of Canada']
  spec.version       = Pathogen::ViewComponents::Version::STRING
  spec.summary       = 'Pathogen View Components'
  spec.description   = 'A Rails Engine gem providing WCAG AA+ compliant ViewComponent-based ' \
                       'UI components for Rails applications'
  spec.homepage      = 'https://github.com/phac-nml/pathogen'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,lib}/**/*', 'LICENSE', 'README.md', 'CHANGELOG.md']
  end
  spec.require_paths = ['lib']
  spec.required_ruby_version = Gem::Requirement.new('>= 3.2.0')
  spec.add_dependency 'actionview', '~> 7.2'
  spec.add_dependency 'activesupport', '~> 7.2'
  spec.add_dependency 'nokogiri', '~> 1.18'
  spec.add_dependency 'rails_icons', '~> 1.4'
  spec.add_dependency 'view_component', '~> 3.23'

  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata['bug_tracker_uri'] = "#{spec.homepage}/issues"
  spec.metadata['documentation_uri'] = 'https://rubydoc.info/gems/pathogen_view_components'
end
