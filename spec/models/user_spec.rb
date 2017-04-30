RSpec.describe User, type: :model do
  describe 'validations' do
    it{ should validate_presence_of(:username) }
  end

  describe 'associations' do
    it{ should have_many(:recipes).with_foreign_key(:author_id) }
    it{ should have_many(:flavors).class_name('UserFlavor') }
    it{ should have_many(:votes) }
    it{ should have_many(:comments).with_foreign_key(:author_id) }
    it{ should have_many(:favorite_recipes) }
    it{ should have_many(:favorites).through(:favorite_recipes).source(:recipe) }
  end

  describe 'indexes' do
    let(:user) { create(:user) }
    let(:update_user) { Proc.new { user.update_attributes(username: 'newusername') } }

    it 'update users index' do
      expect { update_user.call }.to update_index('users#user').and_reindex(user)
    end
  end
end
