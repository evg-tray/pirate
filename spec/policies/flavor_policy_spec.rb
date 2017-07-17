RSpec.describe FlavorPolicy do

  let(:user) { create(:user) }
  let(:user_admin) { create(:user_admin) }
  let(:user_moderator) { create(:user_moderator) }
  let(:user_flavor_creator) { create(:user_flavor_creator)}
  let(:flavor) { create(:flavor) }

  subject { described_class }

  permissions :create? do
    it 'grants access if user admin' do
      expect(subject).to permit(user_admin, flavor)
    end

    it 'grants access if user moderator' do
      expect(subject).to permit(user_moderator, flavor)
    end

    it 'grants access if user flavor creator' do
      expect(subject).to permit(user_flavor_creator, flavor)
    end

    it 'denies access if user not admin or moderator or flavor creator' do
      expect(subject).not_to permit(user, flavor)
    end
  end

  permissions :edit? do
    it 'grants access if user admin' do
      expect(subject).to permit(user_admin, flavor)
    end

    it 'grants access if user moderator' do
      expect(subject).to permit(user_moderator, flavor)
    end

    it 'grants access if user flavor creator' do
      expect(subject).to permit(user_flavor_creator, flavor)
    end

    it 'denies access if user not admin or moderator or flavor creator' do
      expect(subject).not_to permit(user, flavor)
    end
  end

  permissions :update? do
    it 'grants access if user admin' do
      expect(subject).to permit(user_admin, flavor)
    end

    it 'grants access if user moderator' do
      expect(subject).to permit(user_moderator, flavor)
    end

    it 'grants access if user flavor creator' do
      expect(subject).to permit(user_flavor_creator, flavor)
    end

    it 'denies access if user not admin or moderator or flavor creator' do
      expect(subject).not_to permit(user, flavor)
    end
  end
end
