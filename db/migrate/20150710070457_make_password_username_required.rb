class MakePasswordUsernameRequired < ActiveRecord::Migration
  def up
    change_column :admins, :username, :string, null: false
    change_column :admins, :encrypted_password, :string, null: false
    change_column :admins, :salt, :string, null: false
  end

  def down
    change_column :admins, :username, :string, null: true
    change_column :admins, :encrypted_password, :string, null: true
    change_column :admins, :salt, :string, null: true
  end

end
