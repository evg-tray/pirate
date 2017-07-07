class Taste < ApplicationRecord
  has_many :recipes, through: :recipe_tastes
  has_many :recipe_tastes

  validates :name, presence: true
end
