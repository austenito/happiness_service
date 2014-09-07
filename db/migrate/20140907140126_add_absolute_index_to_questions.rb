class AddAbsoluteIndexToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :absolute_index, :integer
  end
end
