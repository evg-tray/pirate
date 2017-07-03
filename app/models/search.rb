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
    results.order(created_at: :desc)
  end

  def self.by_flavors(flavor_ids, without_single_flavor, scope)
    selects = flavor_ids.map{ |i| "SELECT #{i} as Flavor" }.compact.join(' UNION ALL ')
    selects = "SELECT 0 as Flavor" unless selects.present?

    join_query = "INNER JOIN
      (SELECT fr.recipe_id
      FROM flavors_recipes fr
      LEFT JOIN
      (#{selects}) search
      ON fr.flavor_id = search.Flavor
      GROUP BY fr.recipe_id
      HAVING count(case when search.Flavor is null then 1 end) = 0"
    join_query << ' AND count(*) > 1' if without_single_flavor
    join_query << ') fr ON recipes.id = fr.recipe_id'

    if scope == 'public'
      condition = 'recipes.public AND recipes.pirate_diy = false'
    elsif scope == 'pirate_diy'
      condition = 'recipes.pirate_diy'
    else
      condition = 'recipes.public OR recipes.pirate_diy'
    end

    Recipe.sorted.joins(join_query).where(condition).includes(:author)
  end

  def self.escape_flavor_ids(flavor_ids)
    flavor_ids.map{ |i| i if i.to_i > 0 }.compact
  end
end
