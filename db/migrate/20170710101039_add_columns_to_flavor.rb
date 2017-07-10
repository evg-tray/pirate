class AddColumnsToFlavor < ActiveRecord::Migration[5.0]
  def change
    add_column :flavors, :translate, :string
    add_column :flavors, :description, :string
    add_column :flavors, :warning_health, :boolean
    add_column :flavors, :warning_device, :boolean
    add_column :flavors, :warning_description, :string
  end
end
