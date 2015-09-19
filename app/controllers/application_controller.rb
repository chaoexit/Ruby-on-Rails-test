class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :current_user

  def current_user
    user = (User.find(params[:set_user]) rescue nil) || User.first
    logger.debug "User set to #{user.id} (requested #{params[:set_user]})"

    user
  end
end
