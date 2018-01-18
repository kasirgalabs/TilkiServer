class CreateTeachers < ActiveRecord::Migration[5.1]
  def change
    create_table :teachers do |t|
      t.string :email
      t.string :password
      t.string :name
      t.string :surname

      t.timestamps
    end
  end
end
