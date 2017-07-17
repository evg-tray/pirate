RSpec.describe UserFlavor, type: :model do
  describe 'validations' do
    it{ should validate_uniqueness_of(:flavor_id).scoped_to(:user_id) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:flavor) }
  end
end
