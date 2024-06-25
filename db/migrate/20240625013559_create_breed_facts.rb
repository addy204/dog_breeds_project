class CreateBreedFacts < ActiveRecord::Migration[7.1]
  def change
    create_table :breed_facts do |t|
      t.references :breed, null: false, foreign_key: true
      t.text :fact

      t.timestamps
    end
  end
end
