class FlavorSelectAdapter

  def self.select(query, page)
    @term = query
    if @term
      @list = Flavor.where('name LIKE :term', term: "%#{@term}%")
    else
      @list = Flavor.all
    end
    total_count = Flavor.all.count
    {
        items: @list.map do |flavor|
          { text: flavor.name, id: flavor.id }
        end,
        total_count: total_count
    }
  end
end
