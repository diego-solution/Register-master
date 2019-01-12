# frozen_string_literal: true

# handles necessary stuff for report, like stats and export
module ReportStatistics
  extend ActiveSupport::Concern

  # stats
  def number_attendees
    Registrant.where(event_id: id).count
  end

  # stats
  def number_capacity
    capacity
  end

  # stats
  def number_canceled
    Registrant.where(event_id: id, registration_status: "canceled").count
  end

  # stats
  def number_confirmed
    Registrant.where(event_id: id, registration_status: "confirmed").count
  end

  # stats
  def percent_filled
    if capacity.positive?
      "#{(number_confirmed * 100) / capacity}%"
    else
      "0%"
    end
  end

  # export for xls
  def export
    registrants = Registrant.where(event_id: id)
    ReportService.new(event: self, registrants: registrants).export
  end
end
