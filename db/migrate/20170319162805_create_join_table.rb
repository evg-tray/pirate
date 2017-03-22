class CreateJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :recipes, :flavors do |t|
      t.float :amount
      t.index [:recipe_id, :flavor_id]
    end
  end
end
