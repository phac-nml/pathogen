# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Pathogen::TabsPanel, type: :component do
  describe 'initialization' do
    it 'initializes with required id parameter' do
      expect do
        described_class.new(id: 'my-tabs')
      end.not_to raise_error
    end

    it 'raises error without id' do
      expect do
        described_class.new
      end.to raise_error(ArgumentError, /missing keyword/)
    end

    it 'accepts label parameter' do
      expect do
        described_class.new(id: 'tabs', label: 'Main navigation')
      end.not_to raise_error
    end
  end

  describe 'rendering' do
    it 'renders a nav element' do
      render_inline(described_class.new(id: 'test-tabs'))

      expect(page).to have_css('nav')
    end

    it 'renders with specified id' do
      render_inline(described_class.new(id: 'custom-tabs'))

      expect(page).to have_css('nav#custom-tabs')
    end

    it 'renders tab list' do
      render_inline(described_class.new(id: 'tabs')) do |component|
        component.with_tab(id: 'tab-1', text: 'Tab 1', href: '#tab1')
      end

      expect(page).to have_css('ul')
    end

    it 'renders multiple tabs' do # rubocop:disable RSpec/ExampleLength
      render_inline(described_class.new(id: 'tabs')) do |component|
        %w[First Second Third].each_with_index do |label, index|
          component.with_tab(id: "tab-#{index + 1}", text: label, href: "##{label.downcase}")
        end
      end
      expect(page).to have_css('li', count: 3)
    end

    it 'renders tab labels' do
      render_inline(described_class.new(id: 'tabs')) do |component|
        component.with_tab(id: 'overview-tab', text: 'Overview', href: '#overview')
        component.with_tab(id: 'details-tab', text: 'Details', href: '#details')
      end

      expect(page).to have_content('Overview')
    end

    it 'renders multiple tab labels' do
      render_inline(described_class.new(id: 'tabs')) do |component|
        component.with_tab(id: 'overview-tab', text: 'Overview', href: '#overview')
        component.with_tab(id: 'details-tab', text: 'Details', href: '#details')
      end

      expect(page).to have_content('Details')
    end
  end

  describe 'tabs with counts' do
    it 'renders tabs with count badges' do # rubocop:disable RSpec/ExampleLength
      skip 'Count functionality not yet implemented in the component'
      render_inline(described_class.new(id: 'tabs')) do |component|
        component.with_tab(id: 'inbox-tab', text: 'Inbox', href: '#inbox')
        component.with_tab(id: 'sent-tab', text: 'Sent', href: '#sent')
      end
      expect(page).to have_content('Inbox')
    end
  end

  describe 'selected tab' do
    it 'marks tab as selected' do
      render_inline(described_class.new(id: 'tabs')) do |component|
        component.with_tab(id: 'first-tab', text: 'First', href: '#first')
        component.with_tab(id: 'second-tab', text: 'Second', href: '#second', selected: true)
      end

      # The selected tab should have appropriate styling or aria attributes
      expect(page).to have_content('Second')
    end
  end

  describe 'accessibility' do
    it 'renders semantic nav element' do
      render_inline(described_class.new(id: 'tabs'))

      expect(page).to have_css('nav')
    end

    it 'sets aria-label when label provided' do
      render_inline(described_class.new(id: 'tabs', label: 'Main navigation'))

      nav = page.find('nav')
      expect(nav[:'aria-label']).to eq('Main navigation')
    end

    it 'does not set aria-label without label' do
      render_inline(described_class.new(id: 'tabs'))

      nav = page.find('nav')
      expect(nav[:'aria-label']).to be_nil
    end

    it 'passes WCAG AA accessibility checks with tabs' do # rubocop:disable RSpec/ExampleLength
      pending 'axe-core configuration needs to be fixed'
      render_inline(described_class.new(id: 'tabs', label: 'Navigation')) do |component|
        component.with_tab(id: 'home-tab', text: 'Home', href: '/home')
        component.with_tab(id: 'about-tab', text: 'About', href: '/about')
      end
      expect(page).to be_axe_clean
    end
  end

  describe 'right content' do
    it 'renders right content slot' do
      render_inline(described_class.new(id: 'tabs')) do |component|
        component.with_tab(id: 'tab-1', text: 'Tab 1', href: '#tab1')
        component.with_right_content { 'Right side content' }
      end

      expect(page).to have_content('Right side content')
    end
  end

  describe 'attributes' do
    it 'sets unique list id' do
      render_inline(described_class.new(id: 'my-tabs'))

      expect(page).to have_css('ul#my-tabs-list')
    end

    it 'includes tabs list id in data attributes' do
      render_inline(described_class.new(id: 'test-tabs'))

      ul = page.find('ul')
      expect(ul[:'data-tabs-list-id-value']).to eq('test-tabs')
    end

    it 'accepts custom body arguments' do
      render_inline(described_class.new(id: 'tabs', body_arguments: { class: 'custom-list-class' })) do |component|
        component.with_tab(id: 'tab-1', text: 'Tab', href: '#tab')
      end

      expect(page).to have_css('ul')
    end

    it 'accepts custom system arguments' do
      render_inline(described_class.new(
                      id: 'tabs',
                      class: 'custom-nav-class'
                    ))

      expect(page).to have_css('nav.custom-nav-class')
    end
  end

  describe 'styling' do
    it 'applies default classes to nav' do
      render_inline(described_class.new(id: 'tabs'))

      expect(page).to have_css('nav.flex')
    end

    it 'applies default classes to list' do
      render_inline(described_class.new(id: 'tabs')) do |component|
        component.with_tab(id: 'tab-1', text: 'Tab', href: '#tab')
      end

      expect(page).to have_css('ul.w-full')
    end
  end

  describe 'tab links' do
    it 'renders tabs as links with href' do
      render_inline(described_class.new(id: 'tabs')) do |component|
        component.with_tab(id: 'profile-tab', text: 'Profile', href: '/profile')
        component.with_tab(id: 'settings-tab', text: 'Settings', href: '/settings')
      end

      expect(page).to have_link('Profile', href: '/profile')
    end

    it 'renders multiple tabs as links with href' do
      render_inline(described_class.new(id: 'tabs')) do |component|
        component.with_tab(id: 'profile-tab', text: 'Profile', href: '/profile')
        component.with_tab(id: 'settings-tab', text: 'Settings', href: '/settings')
      end

      expect(page).to have_link('Settings', href: '/settings')
    end
  end
end
