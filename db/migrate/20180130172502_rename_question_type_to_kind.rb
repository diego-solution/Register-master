# frozen_string_literal: true

class RenameQuestionTypeToKind < ActiveRecord::Migration[5.1]
  def change
    rename_column :registration_questions, :type, :kind
  end
end
