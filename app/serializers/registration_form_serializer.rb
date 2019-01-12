# frozen_string_literal: true

# frozen_string_literal: true

# serializer for reg forms
class RegistrationFormSerializer < ActiveModel::Serializer
  attributes :id, :name, :archived

  has_many :registration_questions, serializer: RegistrationQuestionSerializer
end
