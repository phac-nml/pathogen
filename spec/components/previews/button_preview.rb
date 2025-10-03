# frozen_string_literal: true

# Previews for the Button component
#
# @label Button
class ButtonPreview < ViewComponent::Preview
  # Default button
  # @label Default
  def default
    render(Pathogen::Button.new) { 'Default Button' }
  end

  # Primary button
  # @label Primary
  def primary
    render(Pathogen::Button.new(scheme: :primary)) { 'Primary Button' }
  end

  # Danger button
  # @label Danger
  def danger
    render(Pathogen::Button.new(scheme: :danger)) { 'Danger Button' }
  end

  # Small button
  # @label Small Size
  def small
    render(Pathogen::Button.new(size: :small)) { 'Small Button' }
  end

  # Medium button
  # @label Medium Size
  def medium
    render(Pathogen::Button.new(size: :medium)) { 'Medium Button' }
  end

  # Large button
  # @label Large Size
  def large
    render(Pathogen::Button.new(size: :large)) { 'Large Button' }
  end

  # Disabled button
  # @label Disabled
  def disabled
    render(Pathogen::Button.new(disabled: true)) { 'Disabled Button' }
  end

  # Block button (full width)
  # @label Block
  def block
    render(Pathogen::Button.new(block: true)) { 'Block Button' }
  end

  # Button with custom classes
  # @label With Custom Classes
  def with_custom_classes
    render(Pathogen::Button.new(classes: 'shadow-lg')) { 'Custom Styled Button' }
  end

  # All schemes comparison
  # @label All Schemes
  def all_schemes
    render_with_template(template: 'button_preview/all_schemes')
  end

  # All sizes comparison
  # @label All Sizes
  def all_sizes
    render_with_template(template: 'button_preview/all_sizes')
  end
end
