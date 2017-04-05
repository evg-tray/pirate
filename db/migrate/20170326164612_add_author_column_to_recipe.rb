class AddAuthorColumnToRecipe < ActiveRecord::Migration[5.0]
  def change
    add_reference :recipes, :author, index: true, foreign_key: { to_table: :users }
  end
end
