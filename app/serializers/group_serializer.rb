# frozen_string_literal: true

# serializer for groups
class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :team_id
  # belongs_to :team
end
