# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Pathogen::Icon, type: :component do
  describe 'initialization' do
    it 'initializes with a valid icon name' do
      expect { described_class.new(:home) }.not_to raise_error
    end

    it 'normalizes icon name' do
      component = described_class.new('clipboard-text')
      expect(component.icon_name).to eq('clipboard-text')
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
  end

  describe 'options handling' do
    it 'builds rails_icons options' do
      component = described_class.new(:info, class: 'custom-class')
      expect(component.rails_icons_options).to be_a(Hash)
      expect(component.rails_icons_options[:class]).to include('custom-class')
    end
  end
end
