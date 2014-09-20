class RenameExternalUserId < ActiveRecord::Migration
  def change
    rename_column :users, :external_user_id, :service_user_id
  end
end
