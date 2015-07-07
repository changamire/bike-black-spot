class CreateUsers < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.index 		:id
  		t.string 		:name
  		t.string 		:email
  		t.string 		:postcode
  		t.string		:uuid
  		t.timestamps
  	end
  end
end
