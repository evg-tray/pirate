RSpec.describe ProfilePolicy do

  let(:user) { create(:user) }
  let(:user_confirmed) { create(:user_confirmed) }
  subject { described_class }

  permissions :update_subscription? do
    it 'grants access if user confirmed' do
      expect(subject).to permit(user_confirmed, :profile)
    end

    it 'denies access if user not confirmed' do
      expect(subject).not_to permit(user, :profile)
    end
  end
end
