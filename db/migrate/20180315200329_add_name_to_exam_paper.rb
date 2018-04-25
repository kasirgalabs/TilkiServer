class AddNameToExamPaper < ActiveRecord::Migration[5.1]
  def change
    add_column :exam_papers, :name, :string
  end
end
