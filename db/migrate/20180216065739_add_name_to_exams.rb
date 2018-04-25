class AddNameToExams < ActiveRecord::Migration[5.1]
  def change
    add_column :exams, :name, :string
  end
end
