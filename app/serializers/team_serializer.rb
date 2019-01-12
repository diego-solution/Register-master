# frozen_string_literal: true

# serializer for teams
class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name #, :total_events, :total_members
end
