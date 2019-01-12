class RemovePlainTextFields < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :plain_first_name, :string
    remove_column :users, :plain_last_name, :string
    remove_column :registrants, :plain_email, :string
    remove_column :registrants, :plain_serialized_answers, :json
  end
end
