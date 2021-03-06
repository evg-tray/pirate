class Recipe < ApplicationRecord
  include RecipeValidations
  include Validable

  has_many :flavors_recipes, inverse_of: :recipe, dependent: :destroy
  has_many :flavors, through: :flavors_recipes
  belongs_to :author, class_name: 'User'
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :recipe_tastes, dependent: :destroy
  has_many :tastes, through: :recipe_tastes

  accepts_nested_attributes_for :flavors_recipes, allow_destroy: true,
                                reject_if: proc { |a| a['flavor_id'].blank? || a['amount'].blank? }

  update_index('flavors#flavor') { flavors }
  update_index 'recipes#recipe', :self

  DEFAULTS = {amount: 30, pg: 30, vg: 70, strength: 0, nicotine_base: 100, drops: 30}

  validates :name, presence: true, length: { minimum: 10, maximum: 200 }
  validate :must_have_flavor
  validate :liquid_integrity

  after_commit :notify_subsribers, on: :create, if: :pirate_diy
  before_save :dedupe_flavors

  scope :sorted, -> { order(created_at: :desc) }
  scope :without_pirate_diy, -> { where(pirate_diy: false) }
  scope :public_recipes, -> { where(public: true, pirate_diy: false) }
  scope :pirate_diy, -> { where(pirate_diy: true) }
  scope :public_pirate, -> { where(public: true).or(where(pirate_diy: true)) }

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

  private

  def notify_subsribers
    PirateDiyJob.perform_later(self)
  end

  def dedupe_flavors
    grouped = flavors_recipes.group_by{|f| [f.recipe_id, f.flavor_id]}
    grouped.values.each do |duplicates|
      duplicates.shift
      duplicates.each{|double| double.destroy}
    end
  end
end
