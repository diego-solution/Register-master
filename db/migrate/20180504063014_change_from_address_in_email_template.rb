class ChangeFromAddressInEmailTemplate < ActiveRecord::Migration[5.1]
  def change
    rename_column :email_templates, :from_address, :default_from_address
    add_column :email_templates, :default_from_name, :string
    add_column :events, :from_name, :string
    add_column :events, :from_address, :string
  end
end
