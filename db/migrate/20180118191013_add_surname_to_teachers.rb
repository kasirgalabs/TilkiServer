class AddSurnameToTeachers < ActiveRecord::Migration[5.1]
  def change
    add_column :teachers, :surname, :string
  end
end
