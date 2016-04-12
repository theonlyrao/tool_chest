class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :most_recent_tool

  def most_recent_tool
    if session[:most_recent_tool_id].nil?
      nil
    else
      tool = Tool.find(session[:most_recent_tool_id])
      tool.name
    end
  end
end
