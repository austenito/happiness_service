class CreateBooleanQuestion < ActiveRecord::Migration
  def change
    create_table :boolean_questions do |t|
      t.timestamps
    end
  end
end
