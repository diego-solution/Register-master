class AddWhenToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :when, :string
  end
end
