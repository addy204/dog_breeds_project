class Owner < ApplicationRecord
  has_many :breeds

  validates :name, presence: true
end
