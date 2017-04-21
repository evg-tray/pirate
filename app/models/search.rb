class Search
  TYPES = %w(public pirate_diy)

  def self.types
    TYPES
  end

  def self.results(query, scope, page)
    if scope == 'public'
      return Recipe.search(ThinkingSphinx::Query.escape(query), with: { pirate_diy: false }, page: page, per_page: 5)
    elsif scope == 'pirate_diy'
      return Recipe.search(ThinkingSphinx::Query.escape(query), with: { pirate_diy: true }, page: page, per_page: 5)
    end
    Recipe.search(ThinkingSphinx::Query.escape(query), page: page, per_page: 5)
  end
end
