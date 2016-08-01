class CreateNews < ActiveRecord::Migration[5.0]
  def change
    create_table :news do |t|
      t.string :headline
      t.string :content
      t.string :author

      t.timestamps
    end
  end
end
