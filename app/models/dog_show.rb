class DogShow < ApplicationRecord
  has_many :breed_dog_shows
  has_many :breeds, through: :breed_dog_shows

  validates :name, presence: true
  validates :date, presence: true
end
