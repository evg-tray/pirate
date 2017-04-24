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
end
