class UserPresenter

  def initialize(user)
    @user = user
  end

  def as(presence)
    send("present_as_#{presence}")
  end

  private

  def present_as_select
    {
        text: @user.username,
        id: @user.id
    }
  end
end
