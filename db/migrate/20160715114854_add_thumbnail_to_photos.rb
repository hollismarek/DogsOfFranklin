class AddThumbnailToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :thumbnail, :string
  end
end
