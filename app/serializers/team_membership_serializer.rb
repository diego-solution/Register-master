# frozen_string_literal: true

# serializer for teams
class TeamMembershipSerializer < ActiveModel::Serializer
  attributes :id, :team_id, :user_id, :admin

  belongs_to :team
end
