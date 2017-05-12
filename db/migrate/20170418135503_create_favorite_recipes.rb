class CreateFavoriteRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :favorite_recipes do |t|
      t.integer :user_id
      t.integer :recipe_id
      t.index [:user_id, :recipe_id], unique: true
    end
  end
end
