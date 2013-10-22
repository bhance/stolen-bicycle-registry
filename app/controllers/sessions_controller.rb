class SessionsController < Devise::SessionsController

protected

  def after_sign_in_path_for(resource)
    session[:previous_url] || new_bicycle_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
#fixme refactor devise stuff
