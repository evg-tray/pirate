class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :user_id, foreign_key: true
      t.integer :recipe_id, foreign_key: true
      t.integer :rating

      t.timestamps
      t.index [:user_id, :recipe_id], unique: true
    end
  end
end
