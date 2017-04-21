class ProfilesController < ApplicationController
  before_action :authenticate_user!

  respond_to :js, only: [:update_settings, :update_setting]

  def settings
  end

  def update_settings
    current_user.update(user_settings)
  end

  private

  def user_settings
    params.require(:user).permit(:pg, :vg, :drops, :strength, :nicotine_base, :amount)
  end
end
