RSpec.describe FlavorPolicy do

  let(:user) { create(:user) }
  let(:user_admin) { create(:user_admin) }
  let(:user_moderator) { create(:user_moderator) }
  let(:flavor) { create(:flavor) }

  subject { described_class }

  permissions :create? do
    it 'grants access if user admin' do
      expect(subject).to permit(user_admin, flavor)
    end

    it 'grants access if user moderator' do
      expect(subject).to permit(user_moderator, flavor)
    end

    it 'denies access if user not admin or moderator' do
      expect(subject).not_to permit(user, flavor)
    end
  end
end
