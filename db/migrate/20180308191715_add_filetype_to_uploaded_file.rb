class AddFiletypeToUploadedFile < ActiveRecord::Migration[5.1]
  def change
    add_column :uploaded_files, :filetype, :string
  end
end
