# frozen_string_literal: true

# Previews for the Tooltip component
#
# @label Tooltip
class TooltipPreview < ViewComponent::Preview
  # Default tooltip
  # @label Default
  def default
    render(Pathogen::Tooltip.new(text: 'This is a tooltip')) { 'Hover over me' }
  end

  # Tooltip with long text
  # @label Long Text
  def long_text
    render(Pathogen::Tooltip.new(
             text: 'This is a longer tooltip with more detailed information about the element.'
           )) do
      'Hover for detailed info'
    end
  end

  # Tooltip on a button
  # @label On Button
  def on_button
    render(Pathogen::Tooltip.new(text: 'Click to save your changes')) do
      render(Pathogen::Button.new(scheme: :primary)) { 'Save' }
    end
  end

  # Tooltip on an icon
  # @label On Icon
  def on_icon
    render(Pathogen::Tooltip.new(text: 'Information')) do
      render(Pathogen::Icon.new(:info, size: :lg))
    end
  end

  # Multiple tooltips
  # @label Multiple Tooltips
  def multiple
    render_with_template(template: 'tooltip_preview/multiple')
  end
end
