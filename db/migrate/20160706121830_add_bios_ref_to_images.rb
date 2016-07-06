class AddBiosRefToImages < ActiveRecord::Migration[5.0]
  def change
    add_reference :images, :bios, foreign_key: true
  end
end
