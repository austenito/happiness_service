class CreateTimeRangeQuestion < ActiveRecord::Migration
  def change
    create_table :time_range_questions do |t|
      t.datetime :start
      t.datetime :end
      t.timestamps
    end
  end
end
