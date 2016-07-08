class RenameImagesTableToPhotos < ActiveRecord::Migration[5.0]
  def change
    rename_table :images, :photos
  end
end
