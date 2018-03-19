class CreateSecurityScores < ActiveRecord::Migration[5.1]
  def change
    create_table :security_scores do |t|
      t.integer :exam_id
      t.integer :student_id
      t.integer :rpskor
      t.integer :fdskor

      t.timestamps
    end
  end
end
