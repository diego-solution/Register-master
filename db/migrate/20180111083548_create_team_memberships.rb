# frozen_string_literal: true

class CreateTeamMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :team_memberships do |t|
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true
      t.boolean :admin

      t.timestamps
    end
  end
end
