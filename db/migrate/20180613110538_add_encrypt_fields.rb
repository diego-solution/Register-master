class AddEncryptFields < ActiveRecord::Migration[5.1]
  def change
    #rename_column :users, :email, :plain_email
    rename_column :users, :first_name, :plain_first_name
    rename_column :users, :last_name, :plain_last_name

    #add_column :users, :email_hash, :string
    #add_column :users, :encrypted_email, :string
    #add_column :users, :encrypted_email_iv, :string
    add_column :users, :encrypted_first_name, :string
    add_column :users, :encrypted_first_name_iv, :string
    add_column :users, :encrypted_last_name, :string
    add_column :users, :encrypted_last_name_iv, :string

    add_column :registrants, :encrypted_email, :string
    add_column :registrants, :encrypted_email_iv, :string
    add_column :registrants, :encrypted_serialized_answers, :string
    add_column :registrants, :encrypted_serialized_answers_iv, :string

    rename_column :registrants, :email, :plain_email
    rename_column :registrants, :serialized_answers, :plain_serialized_answers
    add_column :registrants, :email_hash, :string

    # instructions
    # add to .env file MASTER_KEY='This is a key that is 256 bits!!'
    # rails db:migrate
    # rails eventfuel:migrate_registrant_data
    # rails eventfuel:migrate_user_data
    # TODO another migration to remove plain text fields and migrate data
  end
end
