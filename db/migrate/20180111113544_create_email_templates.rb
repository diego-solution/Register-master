# frozen_string_literal: true

class CreateEmailTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :email_templates do |t|
      t.references :team, foreign_key: true
      t.string :type
      t.string :name
      t.json :content_translations
      t.json :subject_translations
      t.string :from_address

      t.timestamps
    end
  end
end
