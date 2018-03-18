class CreateExamResults < ActiveRecord::Migration[5.1]
  def change
    create_table :exam_results do |t|
      t.integer :exam_id
      t.string :result_url

      t.timestamps
    end
  end
end
