class ManufacturersIndex < Chewy::Index
  settings analysis: {
      analyzer: {
          ng: {
              tokenizer: 'nGram',
              filter: ['lowercase']
          }
      }
  }
  define_type Manufacturer do
    field :name, analyzer: 'ng'
    field :short_name, analyzer: 'ng'
    field :flavors_count, type: 'integer'
  end
end
