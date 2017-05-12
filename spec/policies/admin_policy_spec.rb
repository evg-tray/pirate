RSpec.describe AdminPolicy do

  let(:user) { create(:user) }
  let(:user_admin) { create(:user_admin) }

  subject { described_class }

  permissions :show? do
    it 'grants access if user admin' do
      expect(subject).to permit(user_admin, :admin)
    end

    it 'denies access if user not admin' do
      expect(subject).not_to permit(user, :admin)
    end
  end

  permissions :set_moderator? do
    it 'grants access if user admin' do
      expect(subject).to permit(user_admin, :admin)
    end

    it 'denies access if user not admin' do
      expect(subject).not_to permit(user, :admin)
    end
  end

  permissions :unset_moderator? do
    it 'grants access if user admin' do
      expect(subject).to permit(user_admin, :admin)
    end

    it 'denies access if user not admin' do
      expect(subject).not_to permit(user, :admin)
    end
  end
end
