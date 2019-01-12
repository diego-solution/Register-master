# frozen_string_literal: true
# == Schema Information
#
# Table name: registration_questions
#
#  id                       :integer          not null, primary key
#  registration_form_id     :integer
#  position                 :integer
#  question_translations    :json
#  kind                     :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  required                 :boolean          default(TRUE)
#  width                    :string
#  help_text_translations   :json
#  placeholder_translations :json
#
# Indexes
#
#  index_registration_questions_on_registration_form_id  (registration_form_id)
#
# Foreign Keys
#
#  fk_rails_...  (registration_form_id => registration_forms.id)
#

class RegistrationQuestion < ApplicationRecord
  translates :question
  translates :help_text
  translates :placeholder

  belongs_to :registration_form, optional: true
  acts_as_list scope: [:registration_form_id], top_of_list: 0

  has_many :registration_options, -> { order(position: :asc) }, dependent: :destroy, inverse_of: :registration_question

  #validates :question, presence: true
  validates :kind, inclusion: { in: %w[single email single_other multiple multiple_other text tickbox section],
                                message: "%{value} is not a valid type" }
  #validates_associated :registration_options

  accepts_nested_attributes_for :registration_options, allow_destroy: true

  def to_s
    "#{position}: #{question}"
  end

  def name
    question
  end
end
