class AddInstructorKeyToExams < ActiveRecord::Migration[5.1]
  def change
    add_column :exams, :instructor_key, :integer
  end
end
