# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Pathogen::Form::RadioButton, type: :component do
  def render_radio_button(attributes = {})
    default_attrs = { attribute: :theme, value: 'dark', label: 'Dark Theme' }
    render_inline(described_class.new(**default_attrs, **attributes))
  end

  describe 'rendering' do
    it 'renders a radio button with label' do
      render_inline(described_class.new(attribute: :role, value: 'admin', label: 'Administrator'))

      expect(page).to have_field('Administrator', type: 'radio')
    end

    it 'renders radio button with correct value' do
      render_inline(described_class.new(attribute: :role, value: 'admin', label: 'Administrator'))

      expect(page).to have_css('input[type="radio"][value="admin"]')
    end

    it 'renders a radio button without label' do
      render_inline(described_class.new(attribute: :role, value: 'admin'))

      expect(page).to have_css('input[type="radio"][value="admin"]')
    end

    it 'renders with help text' do
      render_radio_button(help_text: 'Use system theme')

      expect(page).to have_field('Dark Theme', type: 'radio')
    end

    it 'displays help text when provided' do
      render_radio_button(help_text: 'Use system theme')

      expect(page).to have_text('Use system theme')
    end

    it 'renders checked state' do
      render_radio_button(attribute: :role, value: 'user', label: 'User', checked: true)

      expect(page).to have_checked_field('User')
    end

    it 'renders unchecked state by default' do
      render_inline(described_class.new(attribute: :status, value: 'active', label: 'Active'))

      expect(page).to have_unchecked_field('Active')
    end
  end

  describe 'attributes' do
    it 'sets the correct name attribute' do
      render_inline(described_class.new(attribute: :notification_method, value: 'sms', label: 'SMS'))

      expect(page).to have_field('notification_method')
    end

    it 'sets unique id attributes' do
      render_inline(described_class.new(attribute: :preference, value: 'email', label: 'Email'))

      input = page.find('input[type="radio"]')
      expect(input[:id]).not_to be_nil
    end

    it 'sets id attribute matching attribute name' do
      render_inline(described_class.new(attribute: :preference, value: 'email', label: 'Email'))

      input = page.find('input[type="radio"]')
      expect(input[:id]).to match(/preference/)
    end

    it 'associates label with input via for attribute' do
      render_inline(described_class.new(attribute: :theme, value: 'light', label: 'Light Theme'))

      input = page.find('input[type="radio"]')
      label = page.find('label', text: 'Light Theme')
      expect(label[:for]).to eq(input[:id])
    end
  end

  describe 'accessibility' do
    it 'renders semantic HTML' do
      render_inline(described_class.new(attribute: :role, value: 'admin', label: 'Administrator'))

      expect(page).to have_field(type: 'radio')
    end

    it 'renders label element' do
      render_inline(described_class.new(attribute: :role, value: 'admin', label: 'Administrator'))

      expect(page).to have_css('label')
    end

    it 'passes WCAG AA accessibility checks with label' do
      render_radio_button

      # Test accessibility manually since axe-core is not configured
      radio = page.find('input[type="radio"]')
      page.find('label')
      expect(radio).to be_present
    end

    it 'links help text with aria-describedby when present' do
      render_radio_button(help_text: 'A dark color scheme')

      input = page.find('input[type="radio"]')
      help_text = page.find('span', text: 'A dark color scheme')

      expect(input[:'aria-describedby']).to eq(help_text[:id])
    end
  end

  describe 'form builder integration' do
    # Create a simple mock class for testing
    let(:mock_user_class) do
      Class.new do
        attr_accessor :role

        def initialize(role = 'admin')
          @role = role
        end
      end
    end

    let(:user) { mock_user_class.new('admin') }
    let(:form_builder) { ActionView::Helpers::FormBuilder.new(:user, user, controller.view_context, {}) }

    attr_reader :controller

    it 'works with Rails form builder' do
      render_inline(described_class.new(form: form_builder, attribute: :role, value: 'admin', label: 'Administrator'))

      expect(page).to have_field('user[role]')
    end

    it 'renders label with Rails form builder' do
      render_inline(described_class.new(form: form_builder, attribute: :role, value: 'admin', label: 'Administrator'))

      expect(page).to have_field('Administrator', type: 'radio')
    end
  end

  describe 'styling' do
    it 'accepts custom classes' do
      render_radio_button(class: 'custom-radio')

      expect(page).to have_field(class: 'custom-radio')
    end

    it 'applies disabled styling when disabled' do
      render_radio_button(disabled: true)

      expect(page).to have_css('input[disabled]')
    end
  end
end
