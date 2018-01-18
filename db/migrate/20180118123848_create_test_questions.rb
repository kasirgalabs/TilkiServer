class CreateTestQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :test_questions do |t|
      t.integer :exam_id
      t.integer :max_grade
      t.text :description
      t.integer :correct_answer

      t.timestamps
    end
  end
end
