# frozen_string_literal: true

# serializer for events on frontend pages
class PublicEventSerializer < ActiveModel::Serializer
  type "RegistrationEvent"

  attributes :internal_name,
             :slug,
             :url,
             :public_name,
             :city, :location, :country,
             :at_capacity_action,
             :translations,
             :language_key_abreviated,
             :language_key,
             :iso_event_start_date,
             :iso_event_end_date,
             :iso_event_start_date_local,
             :iso_event_end_date_local,
             :when,
             :description,
             :full_capacity,
             :registration_closed,
             :share_ical_url,
             :share_google_url

  has_one :page_content
  belongs_to :registration_form, serializer: RegistrationFormSerializer

  def full_capacity
    object.full?
  end

  # formatted start date
  def iso_event_start_date_local
    object.event_start_date.iso8601
  end

  # formatted end date
  def iso_event_end_date_local
    object.event_end_date.iso8601
  end

  # formatted start date UTC
  def iso_event_start_date
    object.event_start_date.utc.iso8601
  end

  # formatted start date UTC
  def iso_event_end_date
    object.event_end_date.utc.iso8601
  end

  # ex: pt_PT
  def language_key
    object.language.key
  end

  # ex: pt
  def language_key_abreviated
    object.language.key[0..1]
  end

  # all translations for the event. if they dont exist in team, fetch generic
  def translations
    result = {}
    content = Translation.mixed_content_for_team(object.language_id, object.team_id)

    # we shouldn't allow content to be empty
    content = Translation.defaults.by_language(Language.first.id) if content.empty?

    content.each do |trans|
      result.merge!("#{trans.key}": trans.text)
    end
    result
  end

  def share_google_url
    CalendarService.new(event: object).share_url("google")
  end

  def share_ical_url
    CalendarService.new(event: object).share_url("apple")
  end
end
