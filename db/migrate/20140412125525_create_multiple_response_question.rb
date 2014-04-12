class CreateMultipleResponseQuestion < ActiveRecord::Migration
  def change
    create_table :multiple_response_questions do |t|
      t.string :responses, array: true, default: []
      t.boolean :freeform, default: false
      t.timestamps
    end
  end
end
