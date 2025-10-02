# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Pathogen::Button, type: :component do
  describe 'rendering' do
    it 'renders a button with default scheme' do
      render_inline(described_class.new) { 'Click me' }

      expect(page).to have_css('button', text: 'Click me')
    end

    it 'renders a button with primary scheme' do
      render_inline(described_class.new(scheme: :primary)) { 'Submit' }

      expect(page).to have_css('button', text: 'Submit')
    end

    it 'renders a button with danger scheme' do
      render_inline(described_class.new(scheme: :danger)) { 'Delete' }

      expect(page).to have_css('button', text: 'Delete')
    end

    it 'includes custom classes' do
      render_inline(described_class.new(class: 'custom-class')) { 'Click' }

      expect(page).to have_css('button.custom-class')
    end

    it 'includes test selector attribute' do
      render_inline(described_class.new(test_selector: 'submit-button')) { 'Submit' }

      expect(page).to have_css('button[data-test-selector="submit-button"]')
    end
  end

  describe 'accessibility' do
    it 'renders a semantic button element' do
      render_inline(described_class.new) { 'Click' }

      expect(page).to have_selector('button')
    end

    it 'supports aria attributes' do
      render_inline(described_class.new(aria: { label: 'Close dialog' })) { 'X' }

      expect(page).to have_css('button[aria-label="Close dialog"]')
    end

    it 'can be disabled' do
      render_inline(described_class.new(disabled: true)) { 'Submit' }

      expect(page).to have_css('button[disabled]')
    end
  end

  describe 'styling' do
    it 'accepts both :class and :classes for backward compatibility' do
      # Button component accepts both for flexibility
      expect { described_class.new(class: 'custom') }.not_to raise_error
      expect { described_class.new(classes: 'custom') }.not_to raise_error
    end
  end
end
