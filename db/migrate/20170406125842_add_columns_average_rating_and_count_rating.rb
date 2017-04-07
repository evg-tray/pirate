class AddColumnsAverageRatingAndCountRating < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :average_rating, :float, default: 0
    add_column :recipes, :count_rating, :integer, default: 0
  end
end
