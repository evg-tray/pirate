class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :load_user, only: [:add_role, :del_role]
  before_action :load_role, only: [:add_role, :del_role]

  respond_to :js, only: [:set_moderator, :unset_moderator, :enable_disable_registration]

  ROLES = [:moderator, :flavor_creator, :pirate_diy_creator]

  def show
    @users_with_role = User.order(:username).with_any_role(:moderator, :flavor_creator, :pirate_diy_creator)
  end

  def add_role
    @updated = false
    if ROLES.include?(@role) && @user && !@user.has_role?(@role)
      @user.add_role @role
      @user.save
      @updated = true
    end
  end

  def del_role
    @updated = false
    if ROLES.include?(@role) && @user && @user.has_role?(@role)
      @user.remove_role @role
      @user.save
      @updated = true
    end
  end

  def enable_disable_registration
    Setting.disable_registration = params[:disable_registraion] == "0" ? false : true
  end

  private

  def authorize_admin
    authorize :admin
  end

  def load_user
    @user = User.find_by_id(params[:user_id])
  end

  def load_role
    @role = params[:role].to_sym
  end
end
