class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def edit
    group_params
  end

  def update
    group_params
    @group.update(create_params)
    redirect_to root_path
  end

  def create
    @group = Group.new(create_params)
    @group.save
    redirect_to root_path
  end

  private
  def create_params
    params.require(:group).permit(:name, {:user_ids => []})
  end

  def group_params
    @group = Group.find(params[:id])
  end
end
