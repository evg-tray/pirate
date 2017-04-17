class AddColumnSubscribedAndUnsubscribeKeyToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :subscribed, :boolean, default: false
    add_column :users, :unsubscribe_key, :string, default: ""
    add_index :users, :unsubscribe_key
  end
end
