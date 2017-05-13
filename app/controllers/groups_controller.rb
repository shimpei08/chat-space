class GroupsController < ApplicationController
  before_action :group_params, only: [:edit, :update]

  def new
    @group = Group.new
  end

  def edit
  end

  def update
    @group.update(create_params)
    redirect_to root_path
  end

  def create
    @group = Group.new(create_params)
    if @group.save
      redirect_to root_path
    else
      flash[:alert] = 'グループを作成できませんでした'
      render new_group_path
    end
  end

  private
  def create_params
    params.require(:group).permit(:name, {user_ids: []})
  end

  def group_params
    @group = Group.find(params[:id])
  end
end
