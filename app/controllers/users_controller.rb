class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      Session.create(user_id: @user.id)
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
      flash[:notice] = "You have created an account."
    else
    end
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])
    User.update(@user.id, user_params)
    flash[:notice] = "You have updated yourself."
    redirect_to user_path(@user.id)
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
