# frozen_string_literal: true

class CreateReferrers < ActiveRecord::Migration[5.1]
  def change
    create_table :referrers do |t|
      t.string :name
      t.string :email
      t.string :token
      t.string :link
      t.integer :event_id
      t.timestamps
    end
    add_column :registrants, :referrer_id, :integer
  end
end
