module Validable
  extend ActiveSupport::Concern

  included do
    validates :amount, numericality: { only_integer: true, greater_than: 0 }
    validates :strength, numericality: { greater_than_or_equal_to: 0 }
    validates :pg, :vg, :nicotine_base, numericality: { only_integer: true,
                                                        greater_than_or_equal_to: 0,
                                                        less_than_or_equal_to: 100 }
    validate :sum_pg_vg
  end

  def sum_pg_vg
    return unless validate_sum_pg_vg?
    errors.add(:base, :sum_pg_vg) unless pg + vg == 100
  end

  private

  def validate_sum_pg_vg?
    [pg, vg].all?(&:present?)
  end
end
