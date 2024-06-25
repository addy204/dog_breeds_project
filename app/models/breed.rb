class Breed < ApplicationRecord
  belongs_to :owner, optional: true
  has_many :breed_images
  has_many :breed_facts
  has_many :breed_dog_shows
  has_many :dog_shows, through: :breed_dog_shows
end
