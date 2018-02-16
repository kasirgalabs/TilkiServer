class CreateExamResults < ActiveRecord::Migration[5.1]
  def change
    create_table :exam_results do |t|
      t.integer :exam_id
      t.integer :student_id
      t.integer :course_id
      t.integer :totalgrade

      t.timestamps
    end
  end
end
