class CreateTestAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :test_answers do |t|
      t.integer :test_id
      t.integer :student_id
      t.integer :given_answer
      t.integer :recieved_grade

      t.timestamps
    end
  end
end
