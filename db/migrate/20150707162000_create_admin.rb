class CreateAdmin < ActiveRecord::Migration
  def change
    create_table :admin do |t|
      t.index 		:id
      t.string    :name
      t.string   	:password
    end
  end
end
