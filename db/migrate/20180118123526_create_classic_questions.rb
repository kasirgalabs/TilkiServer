class CreateClassicQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :classic_questions do |t|
      t.integer :exam_id
      t.integer :max_grade
      t.text :description

      t.timestamps
    end
  end
end
