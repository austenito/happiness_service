class AddAlwaysShowToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :always_show, :boolean, default: false
  end
end
