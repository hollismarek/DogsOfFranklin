class CreateBios < ActiveRecord::Migration[5.0]
  def change
    create_table :bios do |t|
      t.string :name
      t.integer :age
      t.string :breed
      t.string :likes
      t.string :fears
      t.text :details

      t.timestamps
    end
  end
end
