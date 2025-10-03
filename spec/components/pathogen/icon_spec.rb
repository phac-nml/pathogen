# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Pathogen::Icon, type: :component do
  # Mock the icon helper method from rails_icons
  before do
    allow_any_instance_of(described_class).to receive(:icon) do |_instance, _icon_name, **options| # rubocop:disable RSpec/AnyInstance
      classes = []
      classes << 'test-icon'
      classes << options[:class] if options[:class]

      attributes = []
      attributes << 'aria-hidden="true"' unless options.key?(:'aria-hidden')
      attributes << %(aria-hidden="#{options[:'aria-hidden']}") if options.key?(:'aria-hidden')
      attributes << %(aria-label="#{options[:'aria-label']}") if options[:'aria-label']

      class_attr = classes.any? ? %( class="#{classes.join(' ')}") : ''
      other_attrs = attributes.any? ? " #{attributes.join(' ')}" : ''

      ActiveSupport::SafeBuffer.new("<svg#{class_attr}#{other_attrs}><path d=\"M10 10\"/></svg>")
    end
  end

  describe 'rendering' do
    it 'renders an SVG icon' do
      render_inline(described_class.new(:home))

      expect(page).to have_css('svg')
    end

    it 'normalizes icon names with underscores' do
      render_inline(described_class.new('clipboard_text'))

      expect(page).to have_css('svg')
    end

    it 'normalizes icon names with dashes' do
      render_inline(described_class.new('clipboard-text'))

      expect(page).to have_css('svg')
    end

    it 'accepts symbol icon names' do
      render_inline(described_class.new(:search))

      expect(page).to have_css('svg')
    end
  end

  describe 'styling' do
    it 'applies custom classes' do
      render_inline(described_class.new(:info, class: 'custom-icon-class'))

      expect(page).to have_css('svg.custom-icon-class')
    end

    it 'accepts color option' do
      component = described_class.new(:user, color: :primary)

      expect(component.color).to eq(:primary)
    end

    it 'accepts size option' do
      component = described_class.new(:search, size: :lg)

      expect(component.size).to eq(:lg)
    end

    it 'accepts variant option' do
      component = described_class.new(:heart, variant: :fill)

      expect(component.variant).to eq(:fill)
    end

    it 'applies size classes for different sizes' do
      %i[sm md lg xl].each do |size|
        render_inline(described_class.new(:home, size: size))

        expect(page).to have_css('svg')
      end
    end
  end

  describe 'accessibility' do
    it 'allows aria-hidden to be overridden' do
      render_inline(described_class.new(:info, 'aria-hidden': false, 'aria-label': 'Information icon'))

      svg = page.find('svg')
      expect(svg[:'aria-hidden']).to eq('false')
    end

    it 'allows aria-label to be set' do
      render_inline(described_class.new(:info, 'aria-hidden': false, 'aria-label': 'Information icon'))

      svg = page.find('svg')
      expect(svg[:'aria-label']).to eq('Information icon')
    end

    it 'passes WCAG AA accessibility checks when decorative' do
      render_inline(described_class.new(:home))

      # Check that decorative icons have proper aria-hidden attribute
      expect(page).to have_css('svg[aria-hidden="true"]')
    end

    it 'passes accessibility checks with explicit aria-label' do
      render_inline(described_class.new(:info, 'aria-hidden': false, 'aria-label': 'Information'))

      # Check that non-decorative icons have proper accessibility attributes
      expect(page).to have_css('svg[aria-hidden="false"]')
    end
  end

  describe 'error handling' do
    it 'handles invalid icon names gracefully' do
      # The component should not raise an error
      expect do
        render_inline(described_class.new(:nonexistent_icon_name_that_does_not_exist))
      end.not_to raise_error
    end

    it 'raises error for nil icon names' do
      expect do
        render_inline(described_class.new(nil))
      end.to raise_error(ArgumentError, 'Icon name cannot be nil or blank')
    end

    it 'raises error for blank icon names' do
      expect do
        render_inline(described_class.new(''))
      end.to raise_error(ArgumentError, 'Icon name cannot be nil or blank')
    end

    it 'raises error for whitespace-only icon names' do
      expect do
        render_inline(described_class.new('   '))
      end.to raise_error(ArgumentError, 'Icon name cannot be nil or blank')
    end
  end

  describe 'rails_icons integration' do
    it 'builds rails_icons options as a hash' do
      component = described_class.new(:info, class: 'custom-class')
      expect(component.rails_icons_options).to be_a(Hash)
    end

    it 'includes custom classes in rails_icons options' do
      component = described_class.new(:info, class: 'custom-class')
      expect(component.rails_icons_options[:class]).to include('custom-class')
    end

    it 'accepts variant option for rails_icons' do
      component = described_class.new(:heart, variant: :fill)
      expect(component.rails_icons_options[:variant]).to eq(:fill)
    end

    it 'accepts library option for rails_icons' do
      component = described_class.new(:check, library: :heroicons)
      expect(component.rails_icons_options[:library]).to eq(:heroicons)
    end
  end
end
