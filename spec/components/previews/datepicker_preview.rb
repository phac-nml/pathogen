# frozen_string_literal: true

# Previews for the Datepicker component
#
# @label Datepicker
class DatepickerPreview < ViewComponent::Preview
  # Default datepicker
  # @label Default
  def default
    render(Pathogen::Datepicker.new(
             id: 'event_date',
             input_name: 'event[date]',
             label: 'Event Date'
           ))
  end

  # Datepicker with selected date
  # @label With Selected Date
  def with_selected_date
    render(Pathogen::Datepicker.new(
             id: 'selected_date',
             input_name: 'event[date]',
             label: 'Event Date',
             selected_date: Time.zone.today.to_s
           ))
  end

  # Datepicker with minimum date
  # @label With Minimum Date
  def with_min_date
    render(Pathogen::Datepicker.new(
             id: 'min_date',
             input_name: 'event[date]',
             label: 'Future Event Date',
             min_date: Time.zone.today + 7
           ))
  end

  # Datepicker with autosubmit
  # @label With Autosubmit
  def with_autosubmit
    render(Pathogen::Datepicker.new(
             id: 'autosubmit_date',
             input_name: 'event[date]',
             label: 'Date with Autosubmit',
             autosubmit: true
           ))
  end

  # Datepicker without label (using aria-label)
  # @label Without Visible Label
  def without_label
    render(Pathogen::Datepicker.new(
             id: 'no_label_date',
             input_name: 'event[date]',
             input_aria_label: 'Select event date'
           ))
  end
end
