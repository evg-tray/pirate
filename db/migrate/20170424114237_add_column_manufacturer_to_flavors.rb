class AddColumnManufacturerToFlavors < ActiveRecord::Migration[5.0]
  def change
    add_reference :flavors, :manufacturer, index: true
  end
end
