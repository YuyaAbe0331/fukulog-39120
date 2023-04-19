class CreateGarments < ActiveRecord::Migration[6.0]
  def change
    create_table :garments do |t|
      t.string :name, null: false
      t.integer :genre_id, null: false
      t.integer :category_id, null: false 
      t.string :brand, null: false 
      t.text :material
      t.text :size
      t.text :other
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
