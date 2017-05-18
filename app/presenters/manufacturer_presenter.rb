class ManufacturerPresenter

  def initialize(manufacturer)
    @manufacturer = manufacturer
  end

  def as(presence)
    send("present_as_#{presence}")
  end

  private

  def present_as_select
    {
        text: @manufacturer.name,
        id: @manufacturer.id,
        msn: @manufacturer.short_name,
        count: @manufacturer.flavors_count,
        type: 'm'
    }
  end
end
