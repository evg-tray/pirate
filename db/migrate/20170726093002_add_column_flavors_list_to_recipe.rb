class AddColumnFlavorsListToRecipe < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :flavors_list, :string, default: ''
  end
end
