class UsersIndex < Chewy::Index
  settings analysis: {
      analyzer: {
          ng: {
              tokenizer: 'nGram',
              filter: ['lowercase']
          }
      }
  }
  define_type User do
    field :username, analyzer: 'ng'
  end
end
