# frozen_string_literal: true

# serializer for language
class LanguageSerializer < ActiveModel::Serializer
  cache key: "language", expires_in: 48.hours

  attributes :id, :english_name, :native_name, :key
end
