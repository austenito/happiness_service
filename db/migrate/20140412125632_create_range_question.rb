class CreateRangeQuestion < ActiveRecord::Migration
  def change
    create_table :range_questions do |t|
      t.integer :min, default: 0
      t.integer :max
      t.timestamps
    end
  end
end
