class RemoveColumnFlavorsListFromRecipe < ActiveRecord::Migration[5.0]
  def change
    remove_column :recipes, :flavors_list
  end
end
