class CreateReports < ActiveRecord::Migration
  def change
  	create_table :reports do |t|
  		t.belongs_to 	:user
  		t.belongs_to 	:recipient
  		t.belongs_to 	:category
			t.index 			:id
  		t.string 		 	:uuid
  		t.text 			 	:description 
  		t.string 			:lat
  		t.string 			:long
  		t.timestamps
  		t.datetime 		:sent_at
  	end
  end
end
