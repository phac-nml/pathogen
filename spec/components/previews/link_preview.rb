# frozen_string_literal: true

# Previews for the Link component
#
# @label Link
class LinkPreview < ViewComponent::Preview
  # Default link
  # @label Default
  def default
    render(Pathogen::Link.new(href: '#')) { 'Default Link' }
  end

  # Primary link
  # @label Primary
  def primary
    render(Pathogen::Link.new(href: '#', scheme: :primary)) { 'Primary Link' }
  end

  # Danger link
  # @label Danger
  def danger
    render(Pathogen::Link.new(href: '#', scheme: :danger)) { 'Danger Link' }
  end

  # Link with external URL
  # @label External Link
  def external
    render(Pathogen::Link.new(href: 'https://example.com', target: '_blank', rel: 'noopener')) do
      'External Link'
    end
  end

  # Link with custom classes
  # @label With Custom Classes
  def with_custom_classes
    render(Pathogen::Link.new(href: '#', classes: 'underline font-bold')) { 'Custom Styled Link' }
  end

  # Link with icon
  # @label With Icon
  def with_icon
    render(Pathogen::Link.new(href: '#')) do
      concat render(Pathogen::Icon.new(:arrow_right, size: :sm))
      concat ' Link with Icon'
    end
  end

  # All link schemes
  # @label All Schemes
  def all_schemes
    render_with_template(template: 'link_preview/all_schemes')
  end
end
