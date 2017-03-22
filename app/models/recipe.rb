class Recipe < ApplicationRecord
  has_many :flavors_recipes, inverse_of: :recipe
  has_many :flavors, through: :flavors_recipes

  accepts_nested_attributes_for :flavors_recipes, allow_destroy: true,
                                reject_if: proc { |a| a['flavor_id'].blank? || a['amount'].blank? }

  DEFAULTS = {amount: 30, pg: 30, vg: 70, strength: 0, nicotine_base: 100}

  validates :name, presence: true, length: { minimum: 10, maximum: 200 }
  validates :amount, numericality: { only_integer: true, greater_than: 0 }
  validates :strength, numericality: { greater_than_or_equal_to: 0 }
  validates :pg, :vg, :nicotine_base, numericality: { only_integer: true,
                                                      greater_than_or_equal_to: 0,
                                                      less_than_or_equal_to: 100 }
  validate :liquid_integrity

  def liquid_integrity
    return unless validate_liquid_integrity?

    errors.add(:pg, "Сумма PG и VG должна быть равна 100") unless pg + vg == 100
    pg_in_ml = amount / 100.0 * pg
    nicotine_in_ml = amount / 100.0 * (nicotine_base / 100.0 * strength)
    flavors_in_ml = amount / 100.0 * flavors_recipes.map(&:amount).sum
    if pg_in_ml - nicotine_in_ml - flavors_in_ml < 0
      message = "PG выходит больше, чем указано в основе.
        Указано PG #{pg}%, это - #{pg_in_ml} мл.
        Расчитано #{nicotine_in_ml + flavors_in_ml} мл.
        Необходимо увеличить PG в основе, либо уменьшить крепость или количество ароматизаторов."
      errors.add(:pg, message)
    end
  end

  def self.load_values
    DEFAULTS
  end

  private

  def validate_liquid_integrity?
    !(amount.nil? || pg.nil? || vg.nil? || nicotine_base.nil?)
  end
end
