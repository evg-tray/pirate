class Flavor < ApplicationRecord
  has_many :flavors_recipes, inverse_of: :flavor
  has_many :recipes, through: :flavors_recipes
  belongs_to :manufacturer

  validates :name, presence: true, uniqueness: true, length: { minimum: 10 }
end
