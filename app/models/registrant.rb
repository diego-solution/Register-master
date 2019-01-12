# frozen_string_literal: true
# == Schema Information
#
# Table name: registrants
#
#  id                              :integer          not null, primary key
#  team_id                         :integer
#  event_id                        :integer
#  registration_status             :string
#  token                           :string
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  referrer_id                     :integer
#  encrypted_email                 :string
#  encrypted_email_iv              :string
#  encrypted_serialized_answers    :string
#  encrypted_serialized_answers_iv :string
#  email_hash                      :string
#
# Indexes
#
#  index_registrants_on_event_id  (event_id)
#  index_registrants_on_team_id   (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (team_id => teams.id)
#

class Registrant < ApplicationRecord
  include AASM
  attr_encrypted :email, key: Base64.decode64(ENV["MASTER_KEY"])
  attr_encrypted :serialized_answers, key: Base64.decode64(ENV["MASTER_KEY"]), marshal: true

  belongs_to :team
  belongs_to :event, optional: true
  belongs_to :referrer, optional: true

  has_paper_trail

  validates :email_hash, presence: { message: "E-mail is a missing from answers." }

  has_secure_token

  before_validation :check_event_is_published, on: [:create], if: proc { |reg| reg.event }
  before_validation :check_event_is_full, on: [:create], if: proc { |reg| reg.event }
  before_validation :fetch_email_from_answers
  before_validation :hash_email
  before_validation :check_if_already_registered, on: [:create], unless: proc { |reg| reg.email_hash.blank? }

  after_create :notify_register, if: proc { |reg| reg.event }

  aasm column: "registration_status", logger: Rails.logger do
    state :registered, initial: true
    state :confirmed
    state :canceled

    event :confirm, after_commit: :notify_confirm do
      transitions from: :registered, to: :confirmed, guard: :registration_open?
    end

    event :cancel, after_commit: :notify_cancel do
      transitions from: [:registered, :confirmed], to: :canceled
    end
  end

  def referrer_name
    referrer.nil? ? "" : "#{referrer&.name}  (#{referrer&.email})"
  end

  def full_name
    return "" if serialized_answers.nil?
    keys = ["first name", "last name", "name", "surname"]
    result = []
    serialized_answers.each do |value|
      question = value["question_text"] || value[:question_text]
      val      = value["value"] || value[:value]
      if keys.include?(question.downcase)
        result << val #if keys.include?(value["question_text"].downcase) && !value["value"].nil?
      end
    end
    result.map(&:inspect).join(" ")
  end

  def notify_register
    NotificationsMailer.register(self).deliver if email.present?
  end

  def notify_cancel
    NotificationsMailer.cancel(self).deliver if email.present?
  end

  def notify_confirm
    NotificationsMailer.confirm(self).deliver if email.present?
  end

  def confirm_link
    (ENV["server_root"] || "http://register.eventacc.es") + "/confirmation/#{@event_id}/#{@token}/confirm"
  end

  def confirm_registration(option)
    success = true
    begin
      if option == "confirm"
        confirm!
      elsif option == "cancel"
        cancel!
      end
    rescue AASM::InvalidTransition => e
      success = false
      logger.debug e.to_s
    end

    success
  end

  private
  # checks if registrant already registered for that event
  def check_if_already_registered
    return unless already_registered
    error_msg = Translation.find_or_init_by_key(event.language_id, event.team_id, "confirmation.form.already")
                           .try(:text)
    errors.add(:base, error_msg || "You've already registered for this event.")
  end

  def check_event_is_published
    return if event.nil? || event.published?
    error_msg = Translation.find_or_init_by_key(event.language_id, event.team_id, "registration.error.closed")
                           .try(:text)
    errors.add(:base, error_msg || "Registration is over for this event")
  end

  def check_event_is_full
    return if event.nil?
    return unless event.full? && event.at_capacity_action == "stop"
    return if event.add_to_waitlist?
    error_msg = Translation.find_or_init_by_key(event.language_id, event.team_id, "registration.error.full")
                           .try(:text)
    errors.add(:base, error_msg || "Registration is full for this event")
  end

  def registration_open?
    logger.debug "can I confirm? #{!event.full?}"
    !event.full?
  end

  # go through all answers and get the email I guess
  def fetch_email_from_answers
    result = search_email_in_answers || search_email_in_questions

    logger.debug("found email for registrant #{result}")
    return nil if result.blank?
    self.email = result.downcase
  end

  def hash_email
    self.email_hash = Digest::MD5.hexdigest(email) unless email.blank?
  end

  def already_registered
    event_count = Registrant.where.not(id: id)
                            .where(event_id: event_id, email_hash: Digest::MD5.hexdigest(email))
                            .count
    !event_count.zero?
  end

  # do a simple search in all answers for the word "email"
  def search_email_in_answers
    #keys = ["email", "e-mail"]
    result = nil
    return result if serialized_answers.blank?
    serialized_answers.each do |value|
      question = value["question_text"] || value[:question_text]
      return value["value"] || value[:value] if question.downcase.match(/email/) ||  question.downcase.match(/e-mail/)
    end
    result
  end

  def search_email_in_questions
    result = nil
    return result if serialized_answers.blank?
    serialized_answers.each do |value|
      question = RegistrationQuestion.find_by id: value["question_id"], kind: "email"
      return value["value"] || value[:value] if question
    end
    result
  end
end
