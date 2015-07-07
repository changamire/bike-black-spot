class CreateCategories < ActiveRecord::Migration
  def change
  	create_table :categories do |t|
			t.index 		:id
			t.string 		:name
			t.string 		:description 
			t.string		:uuid
			t.datetime 	:created_at 
		end
  end
end
