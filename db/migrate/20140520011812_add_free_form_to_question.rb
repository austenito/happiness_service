class AddFreeFormToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :freeform, :boolean, default: false
  end
end
