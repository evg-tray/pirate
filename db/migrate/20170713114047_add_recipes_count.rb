class AddRecipesCount < ActiveRecord::Migration[5.0]
  def change
    add_column :flavors, :recipes_count, :integer, default: 0
  end
end
