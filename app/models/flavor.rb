class Flavor < ApplicationRecord
  has_many :flavors_recipes, inverse_of: :flavor
  has_many :recipes, through: :flavors_recipes
  belongs_to :manufacturer, counter_cache: true

  update_index 'flavors#flavor', :self
  update_index('manufacturers#manufacturer') { manufacturer }

  validates :name, presence: true, uniqueness: true, length: { minimum: 10 }

  scope :sorted, -> { order(:name) }
end
