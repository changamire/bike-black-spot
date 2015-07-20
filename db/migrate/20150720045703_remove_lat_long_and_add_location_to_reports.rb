class RemoveLatLongAndAddLocationToReports < ActiveRecord::Migration
  def up
    remove_column :reports, :lat
    remove_column :reports, :long
    add_column :reports, :location, :string

  end

  def down
    remove_column :reports, :location
    add_column :reports, :lat, :string
    add_column :reports, :long, :string
  end
end
