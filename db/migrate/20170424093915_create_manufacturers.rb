class CreateManufacturers < ActiveRecord::Migration[5.0]
  def change
    create_table :manufacturers do |t|
      t.string :name, null: false, index: true
      t.string :short_name, null: false, index: true

      t.timestamps
    end
  end
end
