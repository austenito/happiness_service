class AddKeyToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :key, :string
    add_index :questions, :key
  end
end
