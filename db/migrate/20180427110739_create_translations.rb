class CreateTranslations < ActiveRecord::Migration[5.1]
  def change
    create_table :translations do |t|
      t.string :namespace
      # t.string :locale
      t.string :key
      t.string :text
      t.references :team, foreign_key: true
      t.references :language, foreign_key: true
      t.timestamps
    end
  end
end
