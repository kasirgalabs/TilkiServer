class AddNumberToStudents < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :number, :integer
  end
end
