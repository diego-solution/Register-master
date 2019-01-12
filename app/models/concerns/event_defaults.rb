# frozen_string_literal: true

# handles necessary stuff for event defaults
module EventDefaults
  extend ActiveSupport::Concern

  included do
    before_validation :set_defaults, on: [:create]
    before_validation :set_default_slug, on: [:create]
    before_validation :set_default_registration_dates, on: [:create]
    before_validation :set_default_event_dates, on: [:create]
    before_validation :set_default_capacity, on: [:create]
    before_validation :set_default_profile, on: [:create]
    before_validation :set_default_theme, on: [:create]
    before_validation :set_default_tz, on: [:create]
  end

  private

  def set_defaults
    self.language                 = Language.first if language.nil?
    self.team                     = group.team if group
  end

  def set_default_tz
    self.time_zone                = "Etc/UTC" if time_zone.blank?
  end

  def set_default_capacity
    self.at_capacity_action       = "stop" if at_capacity_action.nil?
    self.capacity                 = 20 if capacity.nil?
  end

  def set_default_registration_dates
    self.registration_start_date  = Time.current if registration_start_date.nil?
    self.registration_close_date  = Time.current + 1.day if registration_close_date.nil?
  end

  def set_default_event_dates
    self.event_start_date         = Time.current if event_start_date.nil?
    self.event_end_date           = Time.current + 1.day if event_end_date.nil?
  end

  def set_default_slug
    self.slug                     = default_slug if slug.blank?
    self.internal_name            = self.public_name.parameterize if self.internal_name.blank?
  end

  def set_default_profile
    #self.page_layout = team.page_layouts.first if team && page_layout.nil?
    self.registration_form = team.registration_forms.first if self.team && self.registration_form.nil?
  end

  def set_default_theme
    return if page_content
    return if team.nil?
    layout_id = self.team.page_layouts.first.id
    self.page_content = PageContent.init_from_page_layout(layout_id)
  end

  def default_slug
    Base64.encode64("#{team_id}#{group_id}").parameterize
  end
end
