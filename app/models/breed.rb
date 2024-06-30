class Breed < ApplicationRecord
  has_many :breed_images
  has_many :breed_facts
  belongs_to :owner, optional: true
  has_and_belongs_to_many :dog_shows

  validates :name, presence: true, uniqueness: true
end
