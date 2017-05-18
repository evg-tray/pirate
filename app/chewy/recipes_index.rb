class RecipesIndex < Chewy::Index
  settings analysis: {
      analyzer: {
          ng: {
              tokenizer: 'nGram',
              filter: ['lowercase']
          }
      }
  }
  define_type Recipe.where(public: true).or(Recipe.where(pirate_diy: true)) do
    field :name, analyzer: 'ng'
    field :pirate_diy, type: 'boolean'
  end
end
