class FlavorsIndex < Chewy::Index
  settings analysis: {
      analyzer: {
          ng: {
              tokenizer: 'nGram',
              filter: ['lowercase']
          }
      }
  }
  define_type Flavor do
    field :name, analyzer: 'ng'
    field :translate, analyzer: 'ng'
    field :manufacturer_name, value: ->(flavor) { "#{flavor.manufacturer.name}" }, analyzer: 'ng'
    field :manufacturer_short_name, value: ->(flavor) { "#{flavor.manufacturer.short_name}" }, analyzer: 'ng'
    field :recipes_count, value: ->(flavor) { FlavorsRecipe.where(flavor_id: flavor.id).count }, analyzer: 'ng'
    field :warning_health, type: 'boolean'
    field :warning_device, type: 'boolean'
  end
end
