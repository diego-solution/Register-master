# frozen_string_literal: true

# serializer for events
class EventSerializer < ActiveModel::Serializer
  attributes :id, :status, :city, :location, :country,
             :registration_start_date, :registration_close_date,
             :at_capacity_action, :capacity, :group_name, :group_id,
             :number_attendees, :number_confirmed, :percent_filled,
             :number_canceled, :public_name, :internal_name,
             :registration_form_id, :slug, :language_id, :url, :when,
             :event_start_date, :event_end_date, :time_zone,
             :description, :page_content, 
             :from_name, :from_address, :from_name_email

  attribute :full?
  attribute :add_to_waitlist?

  belongs_to :language
  belongs_to :registration_form
  belongs_to :group

  def group_name
    object.group.name
  end
end
