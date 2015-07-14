class CreateConfirmations < ActiveRecord::Migration
  def change
    create_table :confirmations do |t|
      t.index 		:id
      t.string 		:token
      t.string		:user
      t.timestamps
    end
  end
end
