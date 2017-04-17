RSpec.describe PirateDiyJob, type: :job do
  let!(:users_subscribers) { create_list(:user, 2, subscribed: true) }
  let!(:users_not_subsribers) { create_list(:user, 2) }
  let!(:pirate_diy_recipe) { create(:recipe, pirate_diy: true) }

  it 'sends email with a new pirate diy recipe to subsribers' do
    users_subscribers.each do |user|
      expect(PirateDiyMailer).to receive(:notify).with(user, pirate_diy_recipe).and_call_original
    end

    users_not_subsribers.each do |user|
      expect(PirateDiyMailer).not_to receive(:notify).with(user, pirate_diy_recipe).and_call_original
    end
    PirateDiyJob.perform_now(pirate_diy_recipe)
  end
end
