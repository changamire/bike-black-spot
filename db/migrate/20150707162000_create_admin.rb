class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.index 		:id
      t.string    :username
      t.string   	:password
      t.timestamps
    end
  end
end
