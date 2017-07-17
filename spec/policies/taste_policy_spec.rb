RSpec.describe TastePolicy do

  let(:user_admin) { create(:user_admin) }
  let(:taste) { create(:taste) }

  subject { described_class }

  permissions :index? do
    it 'grants access is user admin' do
      expect(subject).to permit(user_admin, taste)
    end

    it 'denies access if user not admin' do
      expect(subject).not_to permit(nil, taste)
    end
  end

  permissions :show? do
    it 'grants access is user admin' do
      expect(subject).to permit(user_admin, taste)
    end

    it 'denies access if user not admin' do
      expect(subject).not_to permit(nil, taste)
    end
  end

  permissions :new? do
    it 'grants access is user admin' do
      expect(subject).to permit(user_admin, taste)
    end

    it 'denies access if user not admin' do
      expect(subject).not_to permit(nil, taste)
    end
  end

  permissions :edit? do
    it 'grants access is user admin' do
      expect(subject).to permit(user_admin, taste)
    end

    it 'denies access if user not admin' do
      expect(subject).not_to permit(nil, taste)
    end
  end

  permissions :update? do
    it 'grants access is user admin' do
      expect(subject).to permit(user_admin, taste)
    end

    it 'denies access if user not admin' do
      expect(subject).not_to permit(nil, taste)
    end
  end

  permissions :create? do
    it 'grants access is user admin' do
      expect(subject).to permit(user_admin, taste)
    end

    it 'denies access if user not admin' do
      expect(subject).not_to permit(nil, taste)
    end
  end
end
