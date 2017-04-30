class FlavorSelectAdapter

  def self.select(query, page)
    if query
      @results = FlavorsIndex.query(query_string: {
          fields: [:name, :manufacturer_name, :manufacturer_short_name],
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
              msn: res.manufacturer_short_name,
              mn: res.manufacturer_name,
              count: res.recipes_count,
              type: 'f'
          }
        end,
        total_count: total_count
    }
  end
end
