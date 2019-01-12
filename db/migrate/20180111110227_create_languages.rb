# frozen_string_literal: true

class CreateLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :languages do |t|
      t.string :english_name
      t.string :native_name
      t.string :key

      t.timestamps
    end
  end
end
