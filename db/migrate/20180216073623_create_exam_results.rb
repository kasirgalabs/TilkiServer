class CreateExamResults < ActiveRecord::Migration[5.1]
  def change
    create_table :exam_results do |t|
      t.int :exam_id
      t.int :student_id
      t.int :course_id
      t.int :totalgrade

      t.timestamps
    end
  end
end
