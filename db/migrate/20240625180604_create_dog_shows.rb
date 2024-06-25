class CreateDogShows < ActiveRecord::Migration[7.1]
  def change
    create_table :dog_shows do |t|
      t.string :name
      t.date :date

      t.timestamps
    end
  end
end
