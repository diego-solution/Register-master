# frozen_string_literal: true

class CreateRegistrationForms < ActiveRecord::Migration[5.1]
  def change
    create_table :registration_forms do |t|
      t.references :team, foreign_key: true
      t.string :name
      t.boolean :archived

      t.timestamps
    end
  end
end
