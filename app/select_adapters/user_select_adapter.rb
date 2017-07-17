class UserSelectAdapter

  def self.select(query, page)
    if query
      @results = UsersIndex.query(query_string: {
          fields: [:username],
          query: query,
          default_operator: 'and'
      }).limit(20).offset(20 * (page - 1))
    end
    total_count = @results.total_count
    {
        items: @results.map { |res| UserPresenter.new(res).as(:select) },
        total_count: total_count
    }
  end
end
