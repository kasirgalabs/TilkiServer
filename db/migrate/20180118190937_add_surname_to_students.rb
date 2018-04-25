class AddSurnameToStudents < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :surname, :string
  end
end
