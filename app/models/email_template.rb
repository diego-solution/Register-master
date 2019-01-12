# frozen_string_literal: true
# == Schema Information
#
# Table name: email_templates
#
#  id                   :integer          not null, primary key
#  team_id              :integer
#  kind                 :string
#  name                 :string
#  content_translations :json
#  subject_translations :json
#  default_from_address :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  default_from_name    :string
#
# Indexes
#
#  index_email_templates_on_team_id  (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#

# the email templates used by a team
class EmailTemplate < ApplicationRecord
  belongs_to :team
  has_many :events, dependent: :restrict_with_error

  translates :content
  translates :subject

  validates :name, :kind, presence: true
  #validates :from, presence: true - from comes from the related event

  validates :kind, inclusion: { in: %w[registration cancel waitlist confirmed],
                                message: "%{value} is not a valid type" }
end
