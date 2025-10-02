# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Pathogen::Form::RadioButton, type: :component do
  describe 'initialization' do
    it 'initializes with required parameters' do
      expect { create_radio_button(:role, 'admin', 'Administrator') }.not_to raise_error
    end

    it 'accepts optional form parameter' do
      expect { create_radio_button_with_form(:theme, 'dark', 'Dark Theme') }.not_to raise_error
    end

    it 'accepts label option' do
      component = create_radio_button(:status, 'active', 'Active Status')
      expect(component.instance_variable_get(:@label)).to eq('Active Status')
    end

    it 'accepts help_text option' do
      component = create_radio_button_with_help(:theme, 'system', 'System', 'Use system theme')
      expect(component.instance_variable_get(:@help_text)).to eq('Use system theme')
    end

    it 'accepts checked option' do
      component = create_radio_button_checked(:role, 'user', 'User')
      expect(component.instance_variable_get(:@checked)).to be true
    end
  end

  describe 'value handling' do
    it 'stores the value attribute' do
      component = create_radio_button(:preference, 'email', 'Email')
      expect(component.instance_variable_get(:@value)).to eq('email')
    end

    it 'stores the attribute name' do
      component = create_radio_button(:notification_method, 'sms', 'SMS')
      expect(component.instance_variable_get(:@attribute)).to eq(:notification_method)
    end
  end

  private

  def create_radio_button(attribute, value, label)
    described_class.new(attribute:, value:, label:)
  end

  def create_radio_button_with_form(attribute, value, label)
    described_class.new(attribute:, value:, label:, form: nil)
  end

  def create_radio_button_with_help(attribute, value, label, help_text)
    described_class.new(attribute:, value:, label:, help_text:)
  end

  def create_radio_button_checked(attribute, value, label)
    described_class.new(attribute:, value:, label:, checked: true)
  end
end
