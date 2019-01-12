# frozen_string_literal: true
# == Schema Information
#
# Table name: events
#
#  id                             :integer          not null, primary key
#  team_id                        :integer
#  group_id                       :integer
#  status                         :string
#  internal_name                  :string
#  public_name                    :string
#  language_id                    :integer
#  location                       :string
#  city                           :string
#  country                        :string
#  registration_start_date        :datetime
#  registration_close_date        :datetime
#  additional_data                :json
#  capacity                       :integer
#  at_capacity_action             :string
#  signup_notification_recipients :text
#  header_content_id              :integer
#  registration_form_id           :integer
#  footer_content_id              :integer
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  slug                           :string
#  published_at                   :datetime
#  canceled_at                    :datetime
#  page_layout_id                 :integer
#  from_name                      :string
#  from_address                   :string
#  event_end_date                 :datetime
#  time_zone                      :string
#  event_start_date               :datetime
#  description                    :text
#  when                           :string
#
# Indexes
#
#  index_events_on_group_id              (group_id)
#  index_events_on_language_id           (language_id)
#  index_events_on_page_layout_id        (page_layout_id)
#  index_events_on_registration_form_id  (registration_form_id)
#  index_events_on_team_id               (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (language_id => languages.id)
#  fk_rails_...  (registration_form_id => registration_forms.id)
#  fk_rails_...  (team_id => teams.id)
#

class Event < ApplicationRecord
  include AASM
  include ReportStatistics
  include EventDefaults

  belongs_to :team
  belongs_to :group
  belongs_to :language
  belongs_to :registration_form, optional: true
  has_one :page_content, dependent: :destroy
  has_many :referrers, dependent: :destroy
  has_many :registrants, dependent: :destroy

  has_paper_trail

  before_save :parse_event_time_zones
  before_save :parse_registration_time_zones
  before_destroy :check_if_in_use, prepend: true

  validates :at_capacity_action, inclusion: { in: %w[waitlist stop], message: "%<value> is not a valid type" }

  scope :upcoming, ->(start_date) { where("event_start_date >= ?", start_date) }
  scope :past, ->(start_date) { where("event_start_date <= ?", start_date) }
  scope :recent, ->(date) { where("created_at >= ?", date) }

  # TODO: improve this state machine
  # status, at_capacity_action, header, footer and registration content
  aasm column: "status", logger: Rails.logger do
    state :draft, initial: true
    state :published
    state :finished

    event :publish do
      before do
        logger.debug("Preparing to publish")
      end

      transitions from: :draft, to: :published, guard: :can_we_publish?
    end

    event :unpublish do
      transitions from: :published, to: :draft
    end

    # TODO: do we need this?
    event :finish do
      transitions from: [:draft, :published], to: :finished
    end
  end

  def from_name_email
    return ENV["SENDER_EMAIL"] if from_name.blank? && from_address.blank?
    return "#{from_address.parameterize.underscore}@eventacc.es" if from_name.blank?
    "#{from_name} <#{from_address.parameterize.underscore}@eventacc.es>"
  end

  def can_we_publish?
    logger.debug("we should check if we can publish")
    return false if page_content.nil? || registration_form.nil? || time_zone.nil?
    true
  end

  # TODO: define this
  def url
    open_preview = draft? ? "?preview=true" : ""
    "#{ENV['DOMAIN']}/#/#{slug}/#{internal_name}#{open_preview}"
  end

  def team_name
    team&.name
  end

  # TODO: check if there is still capacity and we can accept people
  def full?
    return true if capacity.nil? || capacity.zero?
    number_confirmed >= capacity
  end

  def add_to_waitlist?
    return false if capacity.nil? || at_capacity_action.nil?
    if number_confirmed > capacity && at_capacity_action == "waitlist"
      true
    else
      false
    end
  end

  def registration_closed
    return false if registration_close_date.nil?
    if Time.current > registration_close_date
      true
    else 
      false
    end
  end

  def regenerate_slug
    update_attributes(
      slug: default_slug,
      internal_name: public_name.parameterize
    )
  end

  private

  def check_if_in_use
    return true if Time.zone.now < self.registration_start_date 
    return true if Time.zone.now > self.registration_close_date
    # return true if self.draft?
    errors.add :base, "Cannot delete #{public_name} because it's a ongoing event. Unpublish or change dates."
    throw(:abort)
  end

  def parse_event_time_zones
    return if time_zone.nil?

    self.event_start_date = ActiveSupport::TimeZone[time_zone].parse event_start_date.to_s if event_start_date
    self.event_end_date   = ActiveSupport::TimeZone[time_zone].parse event_end_date.to_s if event_end_date
  end

  def parse_registration_time_zones
    return if time_zone.nil?
    self.registration_start_date = ActiveSupport::TimeZone[time_zone].parse registration_start_date.to_s if registration_start_date
    self.registration_close_date = ActiveSupport::TimeZone[time_zone].parse registration_close_date.to_s if registration_close_date
  end
end
