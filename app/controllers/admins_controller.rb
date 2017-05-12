class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :load_user, only: [:set_moderator, :unset_moderator]

  respond_to :js, only: [:set_moderator, :unset_moderator]

  def show
    @moderators = User.with_role(:moderator)
  end

  def set_moderator
    @updated = false
    if @user && !@user.has_role?(:moderator)
      @user.add_role :moderator
      @user.save
      @updated = true
    end
  end

  def unset_moderator
    @updated = false
    if @user && @user.has_role?(:moderator)
      @user.remove_role :moderator
      @user.save
      @updated = true
    end
  end

  private

  def authorize_admin
    authorize :admin
  end

  def load_user
    @user = User.find_by_id(params[:user_id])
  end
end
