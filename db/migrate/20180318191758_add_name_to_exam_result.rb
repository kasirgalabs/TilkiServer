class AddNameToExamResult < ActiveRecord::Migration[5.1]
  def change
    add_column :exam_results, :name, :string
  end
end
