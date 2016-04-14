class CategoriesController < ApplicationController

  def index
    @user = User.find(session[:user_id])
    @categories = @user.categories
  end

end
