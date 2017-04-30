RSpec.describe Manufacturer, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:short_name) }
    describe 'uniqueness' do
      subject { build(:manufacturer) }
      it { should validate_uniqueness_of(:name).case_insensitive }
      it { should validate_uniqueness_of(:short_name).case_insensitive }
    end
  end

  describe 'associations' do
    it { should have_many(:flavors) }
  end

  describe 'indexes' do
    let(:manufacturer) { create(:manufacturer) }
    let!(:flavor) { create(:flavor, manufacturer: manufacturer) }
    let(:update_manufacturer) { Proc.new { manufacturer.update_attributes(name: 'new manufacturer name') } }

    it 'update manufacturer index' do
      expect { update_manufacturer.call }.to update_index('manufacturers#manufacturer').and_reindex(manufacturer)
    end

    it 'update flavors index' do
      expect { update_manufacturer.call }.to update_index('flavors#flavor').and_reindex(manufacturer.flavors)
    end
  end
end
