class RenameHashToMd5code < ActiveRecord::Migration[5.1]
  def change
    rename_column :uploaded_files, :hash, :md5code
  end
end
