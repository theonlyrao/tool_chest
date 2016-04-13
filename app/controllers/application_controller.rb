class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :current_user
  helper_method :most_recent_tool

  before_action :reroute_other_user, only: [:edit, :update, :show]

  def reroute_other_user
    if params[:id].to_i != session[:user_id]
      @user = User.find(session[:user_id])
      render :file => "./public/404.html",  :status => 404
    end
  end

  def current_user
    @user ||= Session.find_by(user_id: @user.id)
  end

  def most_recent_tool
    if session[:most_recent_tool_id].nil?
      nil
    else
      tool = Tool.find(session[:most_recent_tool_id])
      tool.name
    end
  end
end
