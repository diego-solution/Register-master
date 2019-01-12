# frozen_string_literal: true

class CreatePageContents < ActiveRecord::Migration[5.1]
  def change
    create_table :page_contents do |t|
      t.references :team, foreign_key: true
      t.string :type
      t.json :content_translations

      t.timestamps
    end
  end
end
