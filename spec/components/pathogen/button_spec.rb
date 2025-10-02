# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Pathogen::Button, type: :component do
  describe 'rendering' do
    it 'renders a button with default scheme' do
      render_button { 'Click me' }
      expect(page).to have_button('Click me')
    end

    it 'renders a button with primary scheme' do
      render_button(scheme: :primary) { 'Submit' }
      expect(page).to have_button('Submit')
    end

    it 'renders a button with danger scheme' do
      render_button(scheme: :danger) { 'Delete' }
      expect(page).to have_button('Delete')
    end

    it 'includes custom classes' do
      render_button(class: 'custom-class') { 'Click' }
      expect(page).to have_button('Click', class: 'custom-class')
    end

    it 'includes test selector attribute' do
      render_button(test_selector: 'submit-button') { 'Submit' }
      expect(page).to have_css('button[data-test-selector="submit-button"]', text: 'Submit')
    end
  end

  describe 'accessibility' do
    it 'renders a semantic button element' do
      render_button { 'Click' }
      expect(page).to have_button('Click')
    end

    it 'supports aria attributes' do
      render_button(aria: { label: 'Close dialog' }) { 'X' }
      expect(page).to have_css('button[aria-label="Close dialog"]', text: 'X')
    end

    it 'can be disabled' do
      render_button(disabled: true) { 'Submit' }
      expect(page).to have_button('Submit', disabled: true)
    end
  end

  describe 'styling' do
    it 'accepts :class parameter for backward compatibility' do
      expect { described_class.new(class: 'custom') }.not_to raise_error
    end

    it 'accepts :classes parameter' do
      expect { described_class.new(classes: 'custom') }.not_to raise_error
    end
  end

  private

  def render_button(**options, &block)
    render_inline(described_class.new(**options), &block)
  end
end
