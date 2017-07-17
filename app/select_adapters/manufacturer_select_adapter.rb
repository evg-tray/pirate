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
        items: @results.map { |res| ManufacturerPresenter.new(res).as(:select) },
        total_count: total_count
    }
  end
end
