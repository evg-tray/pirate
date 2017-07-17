class FlavorsRecipe < ApplicationRecord
  belongs_to :recipe
  belongs_to :flavor, counter_cache: :recipes_count
end
