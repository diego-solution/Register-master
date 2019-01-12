# frozen_string_literal: true

class FixPageContentType < ActiveRecord::Migration[5.1]
  def change
    rename_column :page_contents, :type, :kind
  end
end
