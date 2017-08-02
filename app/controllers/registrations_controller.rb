class RegistrationsController < Devise::RegistrationsController
  before_action :registration_disabled?, only: [:new, :create]

  protected

  def registration_disabled?
    if Setting.disable_registration
      flash[:alert] = t('devise.disabled_registration')
      redirect_to root_path
    end
  end
end
