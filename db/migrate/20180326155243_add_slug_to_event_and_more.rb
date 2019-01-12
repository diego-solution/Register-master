# frozen_string_literal: true

class AddSlugToEventAndMore < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :slug, :string
    add_column :events, :published_at, :datetime
    add_column :events, :canceled_at, :datetime
  end
end
