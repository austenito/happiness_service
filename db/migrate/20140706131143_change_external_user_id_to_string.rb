class ChangeExternalUserIdToString < ActiveRecord::Migration
  def change
    change_column :users, :external_user_id, :string
  end
end
