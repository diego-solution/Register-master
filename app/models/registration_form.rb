# frozen_string_literal: true

# == Schema Information
#
# Table name: registration_forms
#
#  id         :integer          not null, primary key
#  team_id    :integer
#  name       :string
#  archived   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_registration_forms_on_team_id  (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#

# form used on a event's reg page
class RegistrationForm < ApplicationRecord
  belongs_to :team
  has_many :registration_questions, -> { order(position: :asc) }, dependent: :destroy
  has_many :events, dependent: :nullify

  scope :archived, -> { where(archived: true) }

  validates :name, presence: true
  accepts_nested_attributes_for :registration_questions, allow_destroy: true
  before_destroy :check_if_in_use, prepend: true

  private

  def check_if_in_use
    return true if events.count.zero?
    errors.add :base, "Cannot delete #{name} because it's being used in a event."
    throw(:abort)
  end
end