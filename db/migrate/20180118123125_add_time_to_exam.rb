class AddTimeToExam < ActiveRecord::Migration[5.1]
  def change
    add_column :exams, :start_time, :datetime
    add_column :exams, :finish_time, :datetime
  end
end
