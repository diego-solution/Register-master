# frozen_string_literal: true

# serializer for questions
class RegistrationQuestionSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :question,
             :width,
             :placeholder,
             :help_text,
             :kind,
             :required,
             :position
  attribute :_destroy, if: -> { scope && scope[:edit] }

  has_many :registration_options

end