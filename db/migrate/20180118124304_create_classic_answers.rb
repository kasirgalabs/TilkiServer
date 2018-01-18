class CreateClassicAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :classic_answers do |t|
      t.integer :classic_id
      t.integer :student_id
      t.text :given_answer
      t.integer :recieved_grade

      t.timestamps
    end
  end
end
