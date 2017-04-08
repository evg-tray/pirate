RSpec.describe Comment, type: :model do
  describe 'validations' do
    it{ should validate_presence_of(:text) }
    it{ should validate_length_of(:text).is_at_least(10) }
  end

  describe 'associations' do
    it{ should belong_to(:author).class_name('User') }
    it{ should belong_to(:recipe) }
  end
end
