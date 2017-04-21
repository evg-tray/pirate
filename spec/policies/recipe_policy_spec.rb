RSpec.describe RecipePolicy do

  let(:user) { create(:user) }
  let(:user_admin) { create(:user_admin) }
  let(:user_author) { create(:user_moderator) }
  let(:recipe) { create(:recipe, author: user_author) }

  subject { described_class }

  permissions :create? do
    it 'grants access all users' do
      expect(subject).to permit(user, recipe)
    end
  end

  permissions :update? do
    it 'grants access if user admin' do
      expect(subject).to permit(user_admin, recipe)
    end

    it 'grants access if user author' do
      expect(subject).to permit(user_author, recipe)
    end
  end
end
