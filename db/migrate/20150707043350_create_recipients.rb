class CreateRecipients < ActiveRecord::Migration
  def change
  	create_table :recipients do |t|
			t.index 		:id
			t.string 		:name
			t.string 		:email 
			t.string 		:lat
			t.string 		:long
			t.string		:uuid
			t.timestamps
		end
  end
end
