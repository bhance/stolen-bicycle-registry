class RegistrationsController < Devise::RegistrationsController

  protected

  def after_update_path_for(user)
    user_path(user)
  end
end
