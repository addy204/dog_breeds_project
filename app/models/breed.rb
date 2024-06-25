class Breed < ApplicationRecord
  has_many :breed_images
  has_many :breed_facts
end
