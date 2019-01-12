# frozen_string_literal: true

class MoreFieldsToFields < ActiveRecord::Migration[5.1]
  def change
    add_column :registration_questions, :width, :string
    add_column :registration_questions, :help_text_translations, :json
    add_column :registration_questions, :placeholder_translations, :json
  end
end
