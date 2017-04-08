RSpec.describe CommentPolicy do

  let(:user) { create(:user) }
  let(:comment) { create(:comment) }

  subject { described_class }

  permissions :create? do
    it 'grants access if user present' do
      expect(subject).to permit(user, comment)
    end

    it 'denies access if user not present' do
      expect(subject).not_to permit(nil, comment)
    end
  end
end
