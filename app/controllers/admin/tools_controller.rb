class Admin::ToolsController < Admin::BaseController

  def new
    @user = User.find(session[:user_id])
    @tool = Tool.new
  end

  def create
    @tool = Tool.new(tool_params)
    if @tool.save
      @user = User.find(params[:tool][:user_id])
      redirect_to user_path(@user.id)
    else
      flash[:error] = "You must select a non-admin user for this tool."
      redirect_to admin_tools_new_path
    end
  end

  private

  def tool_params
    params.require(:tool).permit(:name, :price, :quantity, :user_id)
  end

end
