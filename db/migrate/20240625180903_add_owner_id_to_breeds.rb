class AddOwnerIdToBreeds < ActiveRecord::Migration[6.1]
  def change
    add_reference :breeds, :owner, foreign_key: true
  end
end
