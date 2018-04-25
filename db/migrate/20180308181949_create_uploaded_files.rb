class CreateUploadedFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :uploaded_files do |t|
      t.integer :exam_id
      t.integer :student_id
      t.string :file_url

      t.timestamps
    end
  end
end
