class CreateBreedDogShows < ActiveRecord::Migration[7.1]
  def change
    create_table :breed_dog_shows do |t|
      t.references :breed, null: false, foreign_key: true
      t.references :dog_show, null: false, foreign_key: true

      t.timestamps
    end
  end
end
