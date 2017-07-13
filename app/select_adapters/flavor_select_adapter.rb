class FlavorSelectAdapter

  def self.select(query, page)
    if query
      @results = FlavorsIndex.query(query_string: {
          fields: [:name, :translate, :manufacturer_name, :manufacturer_short_name],
          query: query,
          default_operator: 'and'
      }).limit(20).offset(20 * (page - 1))
    end
    total_count = @results.total_count
    {
        items: @results.map { |res| FlavorPresenter.new(res).as(:select) },
        total_count: total_count
    }
  end
end
