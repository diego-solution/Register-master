# frozen_string_literal: true

# output format for users
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :first_name, :last_name, :created_at
end
