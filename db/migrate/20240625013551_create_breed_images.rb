class CreateBreedImages < ActiveRecord::Migration[7.1]
  def change
    create_table :breed_images do |t|
      t.references :breed, null: false, foreign_key: true
      t.string :image_url

      t.timestamps
    end
  end
end
