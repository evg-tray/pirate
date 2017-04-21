RSpec.describe UserFlavor, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:flavor) }
  end
end
