# frozen_string_literal: true

class FixEmailTemplateType < ActiveRecord::Migration[5.1]
  def change
    rename_column :email_templates, :type, :kind
  end
end
