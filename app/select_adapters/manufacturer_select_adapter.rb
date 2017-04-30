class ManufacturerSelectAdapter

  def self.select(query, page)
    if query
      @results = ManufacturersIndex.query(query_string: {
          fields: [:name, :short_name],
          query: query,
          default_operator: 'and'
      }).limit(20).offset(20 * (page - 1))
    end
    total_count = @results.total_count
    {
        items: @results.map do |res|
          {
              text: res.name,
              id: res.id,
              msn: res.short_name,
              count: res.flavors_count,
              type: 'm'
          }
        end,
        total_count: total_count
    }
  end
end
