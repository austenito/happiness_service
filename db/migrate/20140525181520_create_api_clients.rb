class CreateApiClients < ActiveRecord::Migration
  def change
    create_table :api_clients do |t|
      t.string :token
      t.string :name
    end
  end
end
