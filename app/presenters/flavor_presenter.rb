class FlavorPresenter

  def initialize(flavor)
    @flavor = flavor
  end

  def as(presence)
    send("present_as_#{presence}")
  end

  private

  def present_as_select
    {
        text: "#{@flavor.name} (#{@flavor.manufacturer_short_name})",
        id: @flavor.id,
        fn: @flavor.name,
        tr: @flavor.translate,
        msn: @flavor.manufacturer_short_name,
        mn: @flavor.manufacturer_name,
        count: @flavor.recipes_count,
        type: 'f'
    }
  end
end
