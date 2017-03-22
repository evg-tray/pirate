class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.integer :amount, null: false
      t.float :strength, null: false
      t.integer :pg, null: false
      t.integer :vg, null: false
      t.integer :nicotine_base, null: false

      t.timestamps
    end
  end
end
