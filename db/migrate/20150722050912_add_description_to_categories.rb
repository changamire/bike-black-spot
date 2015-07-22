class AddDescriptionToCategories < ActiveRecord::Migration
  def up
    add_column :categories, :description, :string
  end

  def down
    remove_column :categories, :description
  end
end
