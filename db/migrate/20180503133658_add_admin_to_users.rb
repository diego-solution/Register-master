class AddAdminToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :super_admin, :boolean, default: false
  end
end
