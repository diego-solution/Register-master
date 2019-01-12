# frozen_string_literal: true
# == Schema Information
#
# Table name: team_memberships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  team_id    :integer
#  admin      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_team_memberships_on_team_id  (team_id)
#  index_team_memberships_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#  fk_rails_...  (user_id => users.id)
#

class TeamMembership < ApplicationRecord
  belongs_to :user
  belongs_to :team

  before_create :set_admin #, on: :create

  private
  def set_admin
    self.admin = false if admin.nil?
  end

end
