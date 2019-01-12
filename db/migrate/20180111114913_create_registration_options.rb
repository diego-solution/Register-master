# frozen_string_literal: true

class CreateRegistrationOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :registration_options do |t|
      t.references :registration_question, foreign_key: true
      t.integer :position
      t.json :option_translations

      t.timestamps
    end
  end
end
