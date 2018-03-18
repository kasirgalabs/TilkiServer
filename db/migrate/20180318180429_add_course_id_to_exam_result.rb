class AddCourseIdToExamResult < ActiveRecord::Migration[5.1]
  def change
    add_column :exam_results, :course_id, :integer
  end
end
