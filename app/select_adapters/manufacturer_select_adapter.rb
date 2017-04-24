class ManufacturerSelectAdapter

  def self.select(query, page)
    @term = query
    if @term
      @list = Manufacturer.where('name LIKE :term', term: "%#{@term}%")
    else
      @list = Manufacturer.all
    end
    total_count = Manufacturer.all.count
    {
        items: @list.map do |manufacturer|
          { text: manufacturer.name, id: manufacturer.id }
        end,
        total_count: total_count
    }
  end
end
