# frozen_string_literal: true
# == Schema Information
#
# Table name: registration_options
#
#  id                       :integer          not null, primary key
#  registration_question_id :integer
#  position                 :integer
#  option_translations      :json
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  value                    :string
#
# Indexes
#
#  index_registration_options_on_registration_question_id  (registration_question_id)
#
# Foreign Keys
#
#  fk_rails_...  (registration_question_id => registration_questions.id)
#

class RegistrationOption < ApplicationRecord
  translates :option

  belongs_to :registration_question, optional: true
  acts_as_list scope: [:registration_question_id], top_of_list: 0

  validates :option, presence: true
  before_save :ensure_value_is_present

  private

  # let's ensure that a value is always present
  def ensure_value_is_present
    self.value = self.option.to_s if self.value.blank?
  end
end
