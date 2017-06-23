class UserFlavor < ApplicationRecord
  belongs_to :user
  belongs_to :flavor

  validates :flavor_id, uniqueness: { scope: :user_id }
end
