class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :path
      t.string :comment
      t.integer :bio_id
      t.timestamps
    end

    add_foreign_key :images, :bios
  end
end
