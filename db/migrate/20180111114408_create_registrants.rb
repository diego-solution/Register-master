# frozen_string_literal: true

class CreateRegistrants < ActiveRecord::Migration[5.1]
  def change
    create_table :registrants do |t|
      t.references :team, foreign_key: true
      t.references :event, foreign_key: true
      t.string :email
      t.json :serialized_answers
      t.string :registration_status
      t.string :token

      t.timestamps
    end
  end
end
