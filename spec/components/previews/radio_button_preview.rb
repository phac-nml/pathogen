# frozen_string_literal: true

# Previews for the RadioButton component
#
# @label RadioButton
class RadioButtonPreview < ViewComponent::Preview
  # Default radio button
  # @label Default
  def default
    render(Pathogen::Form::RadioButton.new(
             attribute: :theme,
             value: 'light',
             label: 'Light Theme'
           ))
  end

  # Radio button with help text
  # @label With Help Text
  def with_help_text
    render(Pathogen::Form::RadioButton.new(
             attribute: :theme,
             value: 'dark',
             label: 'Dark Theme',
             help_text: 'A dark color scheme for better readability at night'
           ))
  end

  # Checked radio button
  # @label Checked
  def checked
    render(Pathogen::Form::RadioButton.new(
             attribute: :theme,
             value: 'system',
             label: 'System Theme',
             checked: true
           ))
  end

  # Disabled radio button
  # @label Disabled
  def disabled
    render(Pathogen::Form::RadioButton.new(
             attribute: :theme,
             value: 'disabled',
             label: 'Disabled Theme',
             disabled: true
           ))
  end

  # Radio button without visible label
  # @label Without Label
  def without_label
    render(Pathogen::Form::RadioButton.new(
             attribute: :theme,
             value: 'unlabeled',
             aria: { label: 'Unlabeled theme option' }
           ))
  end

  # Radio button group
  # @label Group
  def group
    render_with_template(template: 'radio_button_preview/group')
  end
end
