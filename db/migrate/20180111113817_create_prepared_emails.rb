# frozen_string_literal: true

class CreatePreparedEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :prepared_emails do |t|
      t.references :team, foreign_key: true
      t.string :from_address
      t.text :to_addresses
      t.string :subject
      t.text :content
      t.datetime :send_date

      t.timestamps
    end
  end
end
