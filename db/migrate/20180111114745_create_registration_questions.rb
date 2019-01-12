# frozen_string_literal: true

class CreateRegistrationQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :registration_questions do |t|
      t.references :registration_form, foreign_key: true
      t.integer :position
      t.json :question_translations
      t.string :type

      t.timestamps
    end
  end
end
