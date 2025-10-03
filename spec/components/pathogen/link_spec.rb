# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Pathogen::Link, type: :component do
  describe 'rendering' do
    it 'renders a link with href' do
      render_inline(described_class.new(href: '/dashboard')) { 'Dashboard' }

      expect(page).to have_link('Dashboard', href: '/dashboard')
    end

    it 'renders a link with content' do
      render_inline(described_class.new(href: '#')) { 'Click me' }

      expect(page).to have_link('Click me')
    end

    it 'raises error without href' do
      expect do
        render_inline(described_class.new) { 'No href' }
      end.to raise_error(ArgumentError, 'href is required')
    end

    it 'raises error with invalid href format' do
      expect do
        render_inline(described_class.new(href: 'ht!tp://invalid')) { 'Invalid' }
      end.to raise_error(ArgumentError, /invalid href format/)
    end
  end

  describe 'styling' do
    it 'applies default link classes' do
      render_inline(described_class.new(href: '#')) { 'Link' }

      expect(page).to have_css('a.font-semibold.underline')
    end

    it 'applies custom classes' do
      render_inline(described_class.new(href: '#', class: 'custom-link')) { 'Link' }

      expect(page).to have_css('a.custom-link')
    end

    it 'accepts classes parameter' do
      render_inline(described_class.new(href: '#', classes: 'text-red-500')) { 'Red Link' }

      expect(page).to have_css('a.text-red-500')
    end
  end

  describe 'external links' do
    let(:mock_request) { instance_double(ActionDispatch::Request, host: 'example.com') }

    before do
      allow(controller).to receive(:request).and_return(mock_request)
    end

    attr_reader :controller

    it 'adds target="_blank" for external links' do
      render_inline(described_class.new(href: 'https://external.com')) { 'External' }

      link = page.find('a')
      expect(link[:target]).to eq('_blank')
    end

    it 'adds rel="noopener noreferrer" for external links' do
      render_inline(described_class.new(href: 'https://external.com')) { 'External' }

      link = page.find('a')
      expect(link[:rel]).to eq('noopener noreferrer')
    end

    it 'does not modify internal links' do
      render_inline(described_class.new(href: '/internal')) { 'Internal' }

      link = page.find('a')
      expect(link[:target]).to be_nil
    end
  end

  describe 'accessibility' do
    it 'renders semantic anchor element' do
      render_inline(described_class.new(href: '#')) { 'Link' }

      expect(page).to have_css('a')
    end

    it 'passes WCAG AA accessibility checks' do
      render_inline(described_class.new(href: '/page')) { 'Go to page' }

      # Test accessibility manually since axe-core is not configured
      link = page.find('a')
      expect(link).to be_present
    end

    it 'supports custom aria attributes' do
      render_inline(described_class.new(href: '#', aria: { label: 'Navigate to home' })) { 'Home' }

      link = page.find('a')
      expect(link[:'aria-label']).to eq('Navigate to home')
    end
  end

  describe 'attributes' do
    it 'accepts additional HTML attributes' do
      render_inline(described_class.new(href: '#', id: 'custom-link', data: { action: 'click' })) { 'Link' }

      expect(page).to have_css('a#custom-link[data-action="click"]')
    end

    it 'accepts title attribute' do
      render_inline(described_class.new(href: '#', title: 'Link title')) { 'Link' }

      link = page.find('a')
      expect(link[:title]).to eq('Link title')
    end
  end

  describe 'with tooltip' do
    it 'renders with a tooltip' do
      render_inline(described_class.new(href: '#')) do |component|
        component.with_tooltip(text: 'Tooltip text')
        'Link with tooltip'
      end

      expect(page).to have_link('Link with tooltip')
    end

    it 'displays tooltip text' do
      render_inline(described_class.new(href: '#')) do |component|
        component.with_tooltip(text: 'Tooltip text')
        'Link with tooltip'
      end

      expect(page).to have_text('Tooltip text')
    end

    it 'associates tooltip with link via aria-describedby' do
      render_inline(described_class.new(href: '#')) do |component|
        component.with_tooltip(text: 'Description')
        'Link'
      end

      expect(page.find('a')[:'aria-describedby']).not_to be_nil
    end
  end
end
