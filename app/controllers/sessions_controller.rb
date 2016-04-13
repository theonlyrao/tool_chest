class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:sessions][:username])
    if @user && @user.authenticate(params[:sessions][:password])
      Session.create(user_id: @user.id)
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
    end
  end

  def destroy
    holder = Session.find_by(user_id: session[:user_id])
    holder.destroy
    session[:most_recent_tool_id] = nil
    session[:current_tool_count] = 0
    redirect_to login_path
  end

end
