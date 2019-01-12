# frozen_string_literal: true

# options serializer
class RegistrationOptionSerializer < ActiveModel::Serializer
  attributes :id, :position, :option, :value
  attribute :_destroy, if: -> { scope && scope[:edit] }
end