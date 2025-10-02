# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Pathogen::Form::RadioButton, type: :component do
  describe 'initialization' do
    it 'initializes with required parameters' do
      expect do
        described_class.new(
          attribute: :role,
          value: 'admin',
          label: 'Administrator'
        )
      end.not_to raise_error
    end

    it 'accepts optional form parameter' do
      expect do
        described_class.new(
          attribute: :theme,
          value: 'dark',
          label: 'Dark Theme',
          form: nil
        )
      end.not_to raise_error
    end

    it 'accepts label option' do
      component = described_class.new(
        attribute: :status,
        value: 'active',
        label: 'Active Status'
      )

      expect(component.instance_variable_get(:@label)).to eq('Active Status')
    end

    it 'accepts help_text option' do
      component = described_class.new(
        attribute: :theme,
        value: 'system',
        label: 'System',
        help_text: 'Use system theme'
      )

      expect(component.instance_variable_get(:@help_text)).to eq('Use system theme')
    end

    it 'accepts checked option' do
      component = described_class.new(
        attribute: :role,
        value: 'user',
        label: 'User',
        checked: true
      )

      expect(component.instance_variable_get(:@checked)).to be true
    end
  end

  describe 'value handling' do
    it 'stores the value attribute' do
      component = described_class.new(
        attribute: :preference,
        value: 'email',
        label: 'Email'
      )

      expect(component.instance_variable_get(:@value)).to eq('email')
    end

    it 'stores the attribute name' do
      component = described_class.new(
        attribute: :notification_method,
        value: 'sms',
        label: 'SMS'
      )

      expect(component.instance_variable_get(:@attribute)).to eq(:notification_method)
    end
  end
end
