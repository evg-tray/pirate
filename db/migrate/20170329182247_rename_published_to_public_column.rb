class RenamePublishedToPublicColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :recipes, :published, :public
  end
end
