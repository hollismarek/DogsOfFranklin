class CreateAnimalBios < ActiveRecord::Migration[5.0]
  def change
    create_table :animal_bios do |t|
      t.string :name
      t.integer :age
      t.string :breed
      t.string :likes
      t.string :fears
      t.string :details
      t.timestamps
    end

    create_table :animal_images do |t|
      t.integer :animal_bio_id
      t.string :image_path
    end
  end
end
