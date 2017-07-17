class AddFlavorsCount < ActiveRecord::Migration[5.0]
  def change
    add_column :manufacturers, :flavors_count, :integer, default: 0
  end
end
