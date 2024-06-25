class BreedDogShow < ApplicationRecord
  belongs_to :breed
  belongs_to :dog_show
end
