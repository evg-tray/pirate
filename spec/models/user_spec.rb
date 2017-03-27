RSpec.describe User, type: :model do
  describe 'validations' do
    it{ should validate_presence_of(:username) }
  end

  describe 'associations' do
    it{ should have_many(:recipes).with_foreign_key(:author_id) }
  end
end
