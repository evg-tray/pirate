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

  def self.by_flavors(flavor_ids, without_single_flavor)
    selects = flavor_ids.map{ |i| "SELECT #{i} as Flavor" }.compact.join(' UNION ALL ')

    if selects.present?
      query = "SELECT * FROM recipes WHERE recipes.id IN
        (SELECT fr.recipe_id
        FROM flavors_recipes fr
        LEFT JOIN ( #{selects} ) search
        ON fr.flavor_id = search.Flavor
        GROUP BY fr.recipe_id
        HAVING count(case when search.Flavor is null then 1 end) = 0"
      query << ' AND count(*) > 1' if without_single_flavor
      query << ') AND (recipes.public OR recipes.pirate_diy)'

      Recipe.find_by_sql(query)
    else
      nil
    end
  end

  def self.escape_flavor_ids(flavor_ids)
    flavor_ids.map{ |i| i if i.to_i > 0 }.compact
  end
end
