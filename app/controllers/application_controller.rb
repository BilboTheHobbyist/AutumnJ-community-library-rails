class ApplicationController < ActionController::Base
  before_filter :set_locale

  def set_locale
    I18n.locale = params[:locale]
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_cache_buster

  private 
  
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def after_sign_out_path_for(resource_or_scope)
    user_session_path
  end

end
