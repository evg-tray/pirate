class RecipePresenter

  def initialize(rec)
    @rec = rec
  end

  def as(presence)
    send("present_as_#{presence}")
  end

  private

  def present_as_flavors_list
    @rec.flavors_recipes.map { |f| "#{f.flavor.name} (#{f.flavor.manufacturer.short_name})" }.join(', ')
  end
end
