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

  describe 'indexes' do
    let(:flavor) { create(:flavor) }
    let(:update_flavor) { Proc.new { flavor.update_attributes(name: 'new flavor name') } }

    it 'update flavors index' do
      expect { update_flavor.call }.to update_index('flavors#flavor').and_reindex(flavor)
    end

    it 'update manufacturer index' do
      expect { update_flavor.call }.to update_index('manufacturers#manufacturer').and_reindex(flavor.manufacturer)
    end
  end
end
