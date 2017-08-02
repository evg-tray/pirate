class AdminPolicy < Struct.new(:user, :admin)

  def show?
    user.is_admin?
  end

  def add_role?
    user.is_admin?
  end

  def del_role?
    user.is_admin?
  end

  def enable_disable_registration?
    user.is_admin?
  end
end
