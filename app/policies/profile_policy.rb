class ProfilePolicy < Struct.new(:user, :profile)

  def update_subscription?
    user.confirmed?
  end

end
