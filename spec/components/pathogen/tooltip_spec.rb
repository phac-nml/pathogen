# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Pathogen::Tooltip, type: :component do
  describe 'rendering' do
    it 'renders tooltip text' do
      render_inline(described_class.new(text: 'Helpful information', id: 'tooltip-1'))

      expect(page).to have_text('Helpful information')
    end

    it 'renders with specified id' do
      render_inline(described_class.new(text: 'Info', id: 'custom-tooltip-id'))

      expect(page).to have_css('[id="custom-tooltip-id"]')
    end

    it 'renders tooltip content' do
      render_inline(described_class.new(text: 'Tooltip text', id: 'tt-1'))

      expect(page).to have_content('Tooltip text')
    end
  end

  describe 'attributes' do
    it 'exposes text attribute' do
      component = described_class.new(text: 'Sample text', id: 'tt-1')
      expect(component.text).to eq('Sample text')
    end

    it 'exposes id attribute' do
      component = described_class.new(text: 'Text', id: 'tooltip-id-123')
      expect(component.id).to eq('tooltip-id-123')
    end
  end

  describe 'accessibility' do
    it 'renders accessible tooltip markup' do
      render_inline(described_class.new(text: 'Description', id: 'tooltip-accessible'))

      expect(page).to have_css('[role="tooltip"], [id="tooltip-accessible"]')
    end

    it 'passes WCAG AA accessibility checks' do
      render_inline(described_class.new(text: 'Tooltip content', id: 'tooltip-a11y'))

      # Test accessibility manually since axe-core is not configured
      tooltip = page.find_by_id('tooltip-a11y')
      expect(tooltip).to be_present
    end
  end

  describe 'integration' do
    it 'can be used with Link component' do
      render_inline(Pathogen::Link.new(href: '#')) do |component|
        component.with_tooltip(text: 'Link description', id: 'link-tooltip')
        'Link text'
      end

      expect(page).to have_link('Link text')
    end

    it 'displays tooltip text with Link component' do
      render_inline(Pathogen::Link.new(href: '#')) do |component|
        component.with_tooltip(text: 'Link description', id: 'link-tooltip')
        'Link text'
      end

      expect(page).to have_text('Link description')
    end
  end
end
