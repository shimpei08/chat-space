class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    @group.update(update_params)
    redirect_to :root
  end

  def create
    Group.create(create_params)
    redirect_to :root
  end

  private

  def create_params
    params.require(:group).permit(:name, {:user_ids => []})
  end

  def update_params
    params.require(:group).permit(:name, {:user_ids =>[]})
  end
end
