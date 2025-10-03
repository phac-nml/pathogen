# frozen_string_literal: true

# Previews for the Icon component
#
# @label Icon
class IconPreview < ViewComponent::Preview
  # Default icon
  # @label Default
  def default
    render(Pathogen::Icon.new(:home))
  end

  # Icon with primary color
  # @label Primary Color
  def primary_color
    render(Pathogen::Icon.new(:heart, color: :primary))
  end

  # Small icon
  # @label Small Size
  def small
    render(Pathogen::Icon.new(:check, size: :sm))
  end

  # Medium icon
  # @label Medium Size
  def medium
    render(Pathogen::Icon.new(:check, size: :md))
  end

  # Large icon
  # @label Large Size
  def large
    render(Pathogen::Icon.new(:check, size: :lg))
  end

  # Extra large icon
  # @label Extra Large Size
  def extra_large
    render(Pathogen::Icon.new(:check, size: :xl))
  end

  # Icon with fill variant
  # @label Fill Variant
  def fill_variant
    render(Pathogen::Icon.new(:heart, variant: :fill))
  end

  # Icon with custom classes
  # @label With Custom Classes
  def with_custom_classes
    render(Pathogen::Icon.new(:star, class: 'text-yellow-500'))
  end

  # Various common icons
  # @label Common Icons
  def common_icons
    render_with_template(template: 'icon_preview/common_icons')
  end
end
