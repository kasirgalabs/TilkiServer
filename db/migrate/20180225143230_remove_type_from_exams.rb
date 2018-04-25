class RemoveTypeFromExams < ActiveRecord::Migration[5.1]
  def change
    remove_column :exams, :type, :boolean
  end
end
