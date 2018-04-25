class CreateExams < ActiveRecord::Migration[5.1]
  def change
    create_table :exams do |t|
      t.integer :course_id
      t.boolean :type

      t.timestamps
    end
  end
end
