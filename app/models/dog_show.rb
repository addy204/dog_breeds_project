class DogShow < ApplicationRecord
  has_and_belongs_to_many :breeds

  validates :name, presence: true
  validates :date, presence: true
end
