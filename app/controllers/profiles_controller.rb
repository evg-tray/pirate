class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:unsubsribe]

  respond_to :js, only: [:update_settings]

  def settings
  end

  def update_settings
    current_user.update(user_settings)
  end

  def update_subscription
    authorize :profile
    current_user.update(subscription_params)
  end

  def unsubscribe
    @user = User.find_by_unsubscribe_key(params[:key])
    if @user
      @user.update(subscribed: false)
      flash[:notice] = "E-mail: #{@user.email} успешно удален из рассылки."
    else
      flash[:alert] = "Произошла ошибка. Попробуйте еще раз."
    end
  end

  private

  def user_settings
    params.require(:user).permit(:pg, :vg, :drops, :strength, :nicotine_base, :amount)
  end

  def subscription_params
    params.require(:user).permit(:subscribed).merge(unsubscribe_key: Devise.friendly_token)
  end
end
