class CreateJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_table :flavors_recipes do |t|
      t.integer :recipe_id
      t.integer :flavor_id
      t.float :amount
      t.index [:recipe_id, :flavor_id]
    end
  end
end
