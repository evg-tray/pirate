class AdminPolicy < Struct.new(:user, :admin)

  def show?
    user.is_admin?
  end

  def set_moderator?
    user.is_admin?
  end

  def unset_moderator?
    user.is_admin?
  end
end
