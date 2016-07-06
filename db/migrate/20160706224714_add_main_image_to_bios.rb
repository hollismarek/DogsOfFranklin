class AddMainImageToBios < ActiveRecord::Migration[5.0]
  def change
    add_column :bios, :main_image, :string
  end
end
