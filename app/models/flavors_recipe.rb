class FlavorsRecipe < ApplicationRecord
  belongs_to :recipe
  belongs_to :flavor
end
