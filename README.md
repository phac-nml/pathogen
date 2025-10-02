# Pathogen View Components

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Ruby Version](https://img.shields.io/badge/ruby-%3E%3D%203.3.0-ruby.svg)](https://www.ruby-lang.org/en/)
[![Rails Version](https://img.shields.io/badge/rails-%3E%3D%208.0-red.svg)](https://rubyonrails.org/)

A Rails Engine gem providing **WCAG AA+ compliant** ViewComponent-based UI components for Rails applications. Built for public health applications with accessibility, consistency, and developer experience as core values.

## Features

- **Accessibility First**: All components are WCAG AA+ compliant with runtime ARIA validation
- **ViewComponent Architecture**: Leverages ViewComponent gem for performance and testability
- **Consistent API**: Uniform patterns for options, styling, and behavior across all components
- **Rails Engine**: Seamless integration into existing Rails applications
- **i18n Support**: English and French translations included
- **Tailwind CSS**: Modern styling with dark mode support
- **Test-Ready**: Components include automatic `data-test-selector` attributes

## Requirements

- Ruby >= 3.3.0
- Rails >= 8.0
- ViewComponent >= 3.1, < 4.0
- rails_icons >= 1.4.0

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pathogen_view_components'
```

Then execute:

```bash
bundle install
```

## Available Components

### UI Components

- **Button** - Styled buttons with schemes (`:primary`, `:default`, `:danger`) and sizes
- **Icon** - SVG icon rendering via rails_icons
- **Link** - Accessible link component
- **Datepicker** - Date selection with accessibility features
- **Tooltip** - Accessible tooltips
- **TabsPanel** - Tabbed interface with keyboard navigation

### Form Components

- **RadioButton** - Accessible radio button inputs
- **Form Builder** - Custom form builder with WCAG AA+ compliance

All form components integrate with Rails form builders and include proper ARIA attributes.

## Usage

### Basic Component Usage

Components can be used directly or via helper methods:

```erb
<%# Using the component class directly %>
<%= render Pathogen::Button.new(scheme: :primary, size: :medium) do %>
  Click Me
<% end %>

<%# Using the helper method %>
<%= pathogen_button(scheme: :primary, size: :medium) do %>
  Click Me
<% end %>
```

### Button Component

```erb
<%# Primary button %>
<%= pathogen_button(scheme: :primary) do %>
  Submit
<% end %>

<%# Danger button with custom classes %>
<%= pathogen_button(scheme: :danger, classes: "mt-4") do %>
  Delete
<% end %>

<%# Button with icon %>
<%= pathogen_button(scheme: :default) do %>
  <%= pathogen_icon(:search) %>
  Search
<% end %>
```

### Icon Component

```erb
<%# Basic icon %>
<%= pathogen_icon(:home) %>

<%# Icon with custom size and classes %>
<%= pathogen_icon(:user, classes: "w-6 h-6 text-blue-500") %>
```

### Form Components

```erb
<%= form_with model: @user, builder: Pathogen::FormBuilders::PathogenFormBuilder do |f| %>
  <%= f.label :username %>
  <%= f.text_field :username %>

  <%= f.label :role, required: true %>
  <%= f.pathogen_radio_button :role, "admin", label: "Administrator" %>
  <%= f.pathogen_radio_button :role, "user", label: "Standard User" %>

  <%= pathogen_button(scheme: :primary) do %>
    Submit
  <% end %>
<% end %>
```

### Datepicker Component

```erb
<%= pathogen_datepicker(
  id: "event_date",
  name: "event[date]",
  label: "Event Date",
  value: @event.date
) %>
```

### Tooltip Component

```erb
<%= render Pathogen::Tooltip.new(text: "Additional information") do %>
  Hover for details
<% end %>
```

### Tabs Component

```erb
<%= render Pathogen::TabsPanel.new(selected_tab: 0) do |tabs| %>
  <% tabs.with_tab(label: "Overview", count: 5) do %>
    Overview content here
  <% end %>

  <% tabs.with_tab(label: "Details") do %>
    Details content here
  <% end %>
<% end %>
```

## Component Options

### Common Patterns

All components follow these conventions:

- Use `:classes` instead of `:class` for custom CSS classes
- ARIA attributes passed via nested hash: `aria: { describedby: "help-text" }`
- Automatic `data-test-selector` attributes for testing
- Component IDs auto-generated when not provided

### Button Schemes

- `:primary` - Primary action button (blue/prominent)
- `:default` - Secondary action button (neutral)
- `:danger` - Destructive action button (red)

### Button Sizes

Sizes are defined in `Pathogen::ButtonSizes::SIZE_MAPPINGS`:

- `:small`
- `:medium` (default)
- `:large`

## Accessibility Features

This gem enforces WCAG AA+ compliance:

- **Runtime Validation**: Invalid ARIA usage raises errors in development
- **Semantic HTML**: Components use proper HTML elements
- **Keyboard Navigation**: Full keyboard support for all interactive components
- **Screen Reader Support**: Tested with NVDA, JAWS, and VoiceOver
- **Color Contrast**: Meets WCAG AA standards (4.5:1 for text, 3:1 for large text)
- **Focus Management**: Visible focus indicators and logical tab order

## Internationalization

The gem includes English and French translations. Translation keys:

```yaml
pathogen:
  label:
    required_indicator: "*"
    title: "required field"
```

To override translations, add keys to your application's locale files.

## Development

### Setup

```bash
bundle install
```

### Linting

```bash
bundle exec rubocop              # Run linter
bundle exec rubocop -A           # Auto-correct violations
bundle exec rubocop --format offenses  # Show offense counts
```

### Testing

```bash
bundle exec rake test            # Run test suite
```

### Building the Gem

```bash
bundle exec rake build           # Build gem
bundle exec rake install         # Install locally
```

## Architecture

All components inherit from `Pathogen::Component`, which extends `ViewComponent::Base`:

```
ViewComponent::Base
  └── Pathogen::Component
      ├── Pathogen::Button
      ├── Pathogen::Icon
      ├── Pathogen::Link
      ├── Pathogen::Datepicker
      ├── Pathogen::Tooltip
      ├── Pathogen::TabsPanel
      └── Pathogen::Form::*
```

### Key Modules

- `Pathogen::Component` - Base class with validation and helpers
- `Pathogen::FormBuilders::PathogenFormBuilder` - Custom Rails form builder
- `Pathogen::ViewHelper` - View helper methods
- `Pathogen::FormHelper` - Form component utilities
- `Pathogen::TestSelectorHelper` - Automatic test selector generation

## Configuration

The Rails Engine automatically configures ViewComponent:

```ruby
config.view_component.raise_on_invalid_options = false
config.view_component.validate_class_names = true  # non-production
config.view_component.raise_on_invalid_aria = true # non-production
```

## Contributing

### Development Workflow

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Ensure RuboCop passes (`bundle exec rubocop`)
4. Ensure tests pass (`bundle exec rake test`)
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Branch Protection Policy

- **Direct pushes to `main` are disabled** - All changes must go through Pull Requests
- **CI runs on PRs targeting `main`** - Automated tests and linting must pass
- **Required reviews** - Changes require approval from CODEOWNERS
- **Status checks** - All CI jobs must pass before merging

All contributions must maintain WCAG AA+ compliance and follow the project's constitutional principles (see `.specify/memory/constitution.md`).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Developed by **Bioinformatics, Public Health Agency of Canada**
- Built with [ViewComponent](https://viewcomponent.org/)
- Icons provided by [rails_icons](https://github.com/rails/rails_icons)

## Support

- **Bug Reports**: [GitHub Issues](https://github.com/phac-nml/pathogen/issues)
- **Documentation**: [RubyDoc](https://rubydoc.info/gems/pathogen_view_components)
- **Source Code**: [GitHub](https://github.com/phac-nml/pathogen)
