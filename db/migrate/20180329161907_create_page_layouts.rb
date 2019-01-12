# frozen_string_literal: true

class CreatePageLayouts < ActiveRecord::Migration[5.1]
  def change
    create_table :page_layouts do |t|
      t.string :name
      t.boolean :is_original, default: true
      t.boolean :disable_sidebar, default: false
      t.text :preview_image
      t.json :header_translations
      t.json :sidebar_translations
      t.json :body_translations
      t.json :footer_translations
      t.references :team, foreign_key: true
      t.references :page_layout, foreign_key: true
      t.datetime :deleted_at
      t.timestamps
    end

    add_reference :events, :page_layout, index: true
  end
end
