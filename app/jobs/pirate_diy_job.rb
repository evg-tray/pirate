class PirateDiyJob < ApplicationJob
  queue_as :default

  def perform(recipe)
    User.pirate_diy_subscribers.find_each do |user|
      PirateDiyMailer.notify(user, recipe).deliver_later
    end
  end
end
