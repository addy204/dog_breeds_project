class DogShow < ApplicationRecord
  has_many :breed_dog_shows
  has_many :breeds, through: :breed_dog_shows
end
