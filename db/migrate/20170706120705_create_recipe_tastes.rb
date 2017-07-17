class CreateRecipeTastes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipe_tastes do |t|
      t.integer :recipe_id
      t.integer :taste_id
      t.index [:recipe_id, :taste_id], unique: true
    end
  end
end
