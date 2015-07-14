class RemoveLatLongAndAddStateToRecipients < ActiveRecord::Migration
  def up
    remove_column :recipients, :lat
    remove_column :recipients, :long
    add_column :recipients, :state, :string

  end

  def down
    remove_column :recipients, :state
    add_column :recipients, :lat, :string
    add_column :recipients, :long, :string
  end
end
