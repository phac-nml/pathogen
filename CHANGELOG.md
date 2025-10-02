# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.1] - 2025-10-02

### Added

#### Core Components
- Button component with schemes (`:primary`, `:default`, `:danger`) and customizable sizes
- Icon component with rails_icons integration
- Link component with accessibility features
- Datepicker component with WCAG AA+ compliance
- Tooltip component with keyboard navigation support
- TabsPanel component with tab/count subcomponents

#### Form Components
- RadioButton component with WCAG AA+ compliance
- Custom PathogenFormBuilder extending Rails form builder
- Form helper utilities for ARIA attribute management
- Automatic required field indicators with i18n support

#### Architecture
- Base component (`Pathogen::Component`) with argument validation
- FetchOrFallbackHelper for safe option handling
- TestSelectorHelper for automatic test attribute generation
- Rails Engine configuration with ViewComponent integration
- View helpers for all components

#### Styling & Design System
- Tailwind CSS integration with dark mode support
- Button visual schemes and size mappings
- Form styling constants
- Consistent component API patterns

#### Accessibility
- WCAG AA+ compliant components
- Runtime ARIA validation (non-production)
- Semantic HTML enforcement
- Color contrast validation
- Keyboard navigation support
- Screen reader compatibility (NVDA, JAWS, VoiceOver)

#### Internationalization
- English and French translations
- i18n support for required field indicators
- Locale files in `config/locales/`

#### Developer Experience
- RuboCop configuration with Rails and Accessibility cops
- Automatic code style enforcement
- Method length limits (15 lines)
- Comprehensive component documentation

#### Documentation
- Detailed README with usage examples
- MIT License
- CLAUDE.md for AI-assisted development guidance
- Project constitution establishing core principles
- CHANGELOG for version tracking

### Dependencies
- Ruby >= 3.3.0
- Rails >= 8.0
- ViewComponent >= 3.1, < 4.0
- rails_icons >= 1.4.0
- Nokogiri for HTML validation
- ActionView >= 5.0.0
- ActiveSupport >= 5.0.0

### Infrastructure
- Gemspec with proper metadata and file patterns
- Rakefile with test, lint, build tasks
- RSpec test framework setup
- GitHub Actions CI/CD configuration
- Enhanced .gitignore for Ruby gems

[0.0.1]: https://github.com/phac-nml/pathogen/releases/tag/v0.0.1
