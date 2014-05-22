class AddTokenAndExternalIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
    add_column :users, :external_user_id, :integer
    add_index :users, :external_user_id
    add_index :users, :token
  end
end
