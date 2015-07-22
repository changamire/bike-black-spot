class AddReportsImage < ActiveRecord::Migration
  def up
    add_column :reports, :image, :string
  end

  def down
    remove_column :reports, :image
  end
end
