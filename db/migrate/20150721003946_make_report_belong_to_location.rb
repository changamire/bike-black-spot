class MakeReportBelongToLocation < ActiveRecord::Migration
  def up
    remove_column :reports, :location
    add_reference :reports, :location
  end

  def down
    remove_reference :reports, :location
    add_column :reports, :location, :string
  end
end
