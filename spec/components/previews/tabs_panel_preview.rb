# frozen_string_literal: true

# Previews for the TabsPanel component
#
# @label TabsPanel
class TabsPanelPreview < ViewComponent::Preview
  # Default tabs panel
  # @label Default
  def default
    render(Pathogen::TabsPanel.new) do |tabs|
      tabs.with_tab(label: 'Tab 1') { 'Content for Tab 1' }
      tabs.with_tab(label: 'Tab 2') { 'Content for Tab 2' }
      tabs.with_tab(label: 'Tab 3') { 'Content for Tab 3' }
    end
  end

  # Tabs panel with counts
  # @label With Counts
  def with_counts
    render(Pathogen::TabsPanel.new) do |tabs|
      tabs.with_tab(label: 'Inbox', count: 12) { 'Inbox messages' }
      tabs.with_tab(label: 'Sent', count: 5) { 'Sent messages' }
      tabs.with_tab(label: 'Drafts', count: 3) { 'Draft messages' }
    end
  end

  # Tabs panel with second tab selected
  # @label Second Tab Selected
  def second_selected
    render(Pathogen::TabsPanel.new(selected_tab: 1)) do |tabs|
      tabs.with_tab(label: 'Overview') { 'Overview content' }
      tabs.with_tab(label: 'Details') { 'Details content (selected)' }
      tabs.with_tab(label: 'Settings') { 'Settings content' }
    end
  end

  # Tabs panel with rich content
  # @label With Rich Content
  def with_rich_content
    render(Pathogen::TabsPanel.new) do |tabs|
      tabs.with_tab(label: 'Profile') { profile_content }
      tabs.with_tab(label: 'Activity', count: 8) { activity_content }
    end
  end

  private

  def profile_content
    tag.div(class: 'p-4') do
      tag.h3('User Profile', class: 'text-lg font-bold mb-2') +
        tag.p('This is a profile tab with formatted content.')
    end
  end

  def activity_content
    tag.div(class: 'p-4') do
      tag.ul(class: 'list-disc pl-4') do
        tag.li('Activity 1') +
          tag.li('Activity 2') +
          tag.li('Activity 3')
      end
    end
  end
end
