RSpec.describe Flavor, type: :model do
  describe 'validations' do
    subject { build(:flavor) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:name).is_at_least(10) }
  end

  describe 'associations' do
    it { should have_many(:flavors_recipes).inverse_of(:flavor) }
    it { should have_many(:recipes).through(:flavors_recipes) }
    it { should belong_to(:manufacturer) }
  end
end
