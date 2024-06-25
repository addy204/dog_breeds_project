class BreedFact < ApplicationRecord
  belongs_to :breed

  validates :fact, presence: true
  validates :breed, presence: true
end
