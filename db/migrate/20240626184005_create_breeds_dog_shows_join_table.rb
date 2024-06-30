class CreateBreedsDogShowsJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_join_table :breeds, :dog_shows do |t|
      # t.index [:breed_id, :dog_show_id]
      # t.index [:dog_show_id, :breed_id]
    end
  end
end
