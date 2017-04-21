class Recipe < ApplicationRecord
  include RecipeValidations
  include Validable

  has_many :flavors_recipes, inverse_of: :recipe
  has_many :flavors, through: :flavors_recipes
  belongs_to :author, class_name: 'User'

  accepts_nested_attributes_for :flavors_recipes, allow_destroy: true,
                                reject_if: proc { |a| a['flavor_id'].blank? || a['amount'].blank? }

  DEFAULTS = {amount: 30, pg: 30, vg: 70, strength: 0, nicotine_base: 100, drops: 30}

  validates :name, presence: true, length: { minimum: 10, maximum: 200 }
  validate :liquid_integrity

  scope :public_recipes, -> { where(public: true, pirate_diy: false) }
  scope :pirate_diy, -> { where(pirate_diy: true) }

  def self.initial_values(user)
    if user
      return {
          amount: user.amount,
          pg: user.pg,
          vg: user.vg,
          strength: user.strength,
          nicotine_base: user.nicotine_base,
          drops: user.drops
      }
    end
    DEFAULTS
  end
end
