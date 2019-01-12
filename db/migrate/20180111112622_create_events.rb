# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.references :team, foreign_key: true
      t.references :group, foreign_key: true
      t.string :status
      t.string :internal_name
      t.string :public_name
      t.references :language, foreign_key: true
      t.string :location
      t.string :city
      t.string :country
      t.datetime :start_date
      t.datetime :registration_close_date
      t.json :additional_data
      t.integer :capacity
      t.string :at_capacity_action
      t.text :signup_notification_recipients
      t.integer :header_content_id
      t.references :registration_form, foreign_key: true
      t.integer :footer_content_id

      t.timestamps
    end
  end
end
