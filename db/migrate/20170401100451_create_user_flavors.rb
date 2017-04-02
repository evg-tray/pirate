class CreateUserFlavors < ActiveRecord::Migration[5.0]
  def change
    create_table :user_flavors do |t|
      t.integer :user_id
      t.integer :flavor_id
      t.boolean :available, default: true
      t.index [:user_id, :flavor_id], unique: true
    end
  end
end
