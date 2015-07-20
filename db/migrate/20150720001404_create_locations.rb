class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.index 		:id
      t.string 		:uuid
      t.string 		:lat
      t.string 		:long
      t.string		:number
      t.string		:street
      t.string		:suburb
      t.string		:state
      t.string		:postcode
      t.string		:country
      t.string		:formatted_address
      t.timestamps
    end
  end
end
