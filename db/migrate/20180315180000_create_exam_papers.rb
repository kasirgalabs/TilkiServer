class CreateExamPapers < ActiveRecord::Migration[5.1]
  def change
    create_table :exam_papers do |t|
      t.integer :exam_id
      t.string :file_url

      t.timestamps
    end
  end
end
