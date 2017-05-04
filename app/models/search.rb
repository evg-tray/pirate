class Search
  TYPES = %w(public pirate_diy)

  def self.types
    TYPES
  end

  def self.by_name(query, scope)
    results = RecipesIndex.query(query_string: {
        fields: [:name],
        query: query,
        default_operator: 'and'
    })
    if scope == 'public'
      results = results.query(term: {pirate_diy: false})
    elsif scope == 'pirate_diy'
      results = results.query(term: {pirate_diy: true})
    end
    results
  end

  def self.by_flavors(flavor_ids, without_single_flavor)
    selects = flavor_ids.map{ |i| "SELECT #{i} as Flavor" }.compact.join(' UNION ALL ')
    selects = "SELECT 0 as Flavor" unless selects.present?

    join_query = "INNER JOIN
      (SELECT fr.recipe_id
      FROM flavors_recipes fr
      INNER JOIN
      (#{selects}) search
      ON fr.flavor_id = search.Flavor
      GROUP BY fr.recipe_id"
    join_query << ' HAVING count(*) > 1' if without_single_flavor
    join_query << ') fr ON recipes.id = fr.recipe_id'
    Recipe.joins(join_query).where('recipes.public OR recipes.pirate_diy').includes(:author)
  end

  def self.escape_flavor_ids(flavor_ids)
    flavor_ids.map{ |i| i if i.to_i > 0 }.compact
  end
end
