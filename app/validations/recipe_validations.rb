module RecipeValidations

  def liquid_integrity
    return unless validate_liquid_integrity?

    pg_in_ml = amount / 100.0 * pg
    nicotine_in_ml = amount / 100.0 * (strength * 100 / nicotine_base)
    flavors_in_ml = amount / 100.0 * flavors_recipes.map(&:amount).sum
    if pg_in_ml - nicotine_in_ml - flavors_in_ml < 0
      errors.add(:base, :wrong_amount,
                 pg_percent: pg,
                 pg_in_ml: pg_in_ml.round(2),
                 total_pg_in_ml: (nicotine_in_ml + flavors_in_ml).round(2)
      )
    end
  end

  def must_have_flavor
    if flavors_recipes.empty? or flavors_recipes.all? { |fr| fr.marked_for_destruction? }
      errors.add(:base, :must_have_flavor)
    end
  end

  private

  def validate_liquid_integrity?
    [amount, pg, vg, nicotine_base].all?(&:present?)
  end
end
