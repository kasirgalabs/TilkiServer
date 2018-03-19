class AddHashToUploadedFile < ActiveRecord::Migration[5.1]
  def change
    add_column :uploaded_files, :hash, :string
  end
end
