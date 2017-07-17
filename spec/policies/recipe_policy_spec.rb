RSpec.describe RecipePolicy do

  let(:user) { create(:user) }
  let(:user_admin) { create(:user_admin) }
  let(:user_author) { create(:user) }
  let(:recipe) { create(:recipe, author: user_author) }
  let(:recipe_public) { create(:recipe, public: true) }
  let(:recipe_private) { create(:recipe, public: false) }

  subject { described_class }

  permissions :create? do
    it 'grants access all registered users' do
      expect(subject).to permit(user, recipe)
    end

    it 'denies access non-registered users' do
      expect(subject).not_to permit(nil, recipe)
    end
  end

  permissions :update? do
    it 'grants access if user admin' do
      expect(subject).to permit(user_admin, recipe)
    end

    it 'grants access if user author' do
      expect(subject).to permit(user_author, recipe)
    end

    it 'denises access if user not author or admin' do
      expect(subject).not_to permit(user, recipe)
    end
  end

  permissions :destroy? do
    it 'grants access if user admin' do
      expect(subject).to permit(user_admin, recipe)
    end

    it 'grants access if user author' do
      expect(subject).to permit(user_author, recipe)
    end

    it 'denises access if user not author or admin' do
      expect(subject).not_to permit(user, recipe)
    end
  end

  permissions :add_favorites? do
    it 'grants access if record public' do
      expect(subject).to permit(user, recipe_public)
    end

    it 'grants access if user author' do
      expect(subject).to permit(user_author, recipe)
    end

    it 'denies access if recipe not public and user not author' do
      expect(subject).not_to permit(user, recipe_private)
    end
  end

  permissions :show? do
    it 'grants access all users to public recipe' do
      expect(subject).to permit(nil, recipe_public)
    end

    it 'grants access if user author' do
      expect(subject).to permit(user_author, recipe)
    end

    it 'grants access if user admin' do
      expect(subject).to permit(user_admin, recipe)
    end

    it 'denies access to private recipe if user not admin and not author' do
      expect(subject).not_to permit(user, recipe)
    end
  end
end
