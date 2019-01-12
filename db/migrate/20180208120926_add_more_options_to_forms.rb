# frozen_string_literal: true

class AddMoreOptionsToForms < ActiveRecord::Migration[5.1]
  def change
    add_column :registration_questions, :required, :boolean, default: true
    add_column :registration_options, :value, :string
  end
end
