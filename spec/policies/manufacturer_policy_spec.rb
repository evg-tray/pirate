RSpec.describe ManufacturerPolicy do

  let(:user) { create(:user) }
  let(:user_admin) { create(:user_admin) }
  let(:user_moderator) { create(:user_moderator) }
  let(:user_flavor_creator) { create(:user_flavor_creator)}
  let(:manufacturer) { create(:manufacturer) }

  subject { described_class }

  permissions :create? do
    it 'grants access if user admin' do
      expect(subject).to permit(user_admin, manufacturer)
    end

    it 'grants access if user moderator' do
      expect(subject).to permit(user_moderator, manufacturer)
    end

    it 'grants access if user flavor creator' do
      expect(subject).to permit(user_flavor_creator, manufacturer)
    end

    it 'denies access if user not admin or moderator or flavor creator' do
      expect(subject).not_to permit(user, manufacturer)
    end
  end
end
