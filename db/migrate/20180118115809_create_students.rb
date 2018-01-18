class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :email
      t.string :password
      t.string :name
      t.string :surname

      t.timestamps
    end
  end
end
