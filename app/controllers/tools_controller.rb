class ToolsController < ApplicationController
  helper_method :most_recent_tool

  def index
    @tools = Tool.all
  end

  def show
    @user = User.find(session[:user_id])
    @tool = Tool.find(params[:id])
  end

  def new
    @user = User.find(session[:user_id])
    @tool = Tool.new
  end

  def create
    session[:current_tool_count] = 0 if session[:most_recent_tool_id].nil?
    @tool = Tool.new(tool_params)
    if @tool.save
      @tool.update_attribute :user_id, "#{session[:user_id]}"
      flash[:notice] = "Tool successfully created"
      session[:most_recent_tool_id] = @tool.id
      session[:current_tool_count] += 1
      redirect_to tool_path(@tool.id)
    else
      flash[:error] = @tool.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @tool = Tool.find(params[:id])
  end

  def update
    @tool = Tool.find(params[:id])
    if @tool.update_attributes( tool_params )
      redirect_to tool_path
    else
      redirect_to edit_tool_path(@tool.id)
    end
  end

  def destroy
    tool = Tool.find(params[:id])
    tool.destroy
    redirect_to tools_path
  end

  private

  def tool_params
    params.require(:tool).permit(:name, :price, :quantity)
  end


end
