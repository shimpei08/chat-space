class MessagesController < ApplicationController

  def index
    @groups = current_user.groups.order('created_at DESC')
  end

  def new
    @groups = current_user.groups.order('created_at DESC')
    @group = Group.find(params[:group_id])
    @messages = Message.where(group_id: @group.id).order('created_at DESC')
    @message = Message.new
  end

  def create
    @message = Message.new(create_params)
    @message.save
    redirect_to new_group_message_path
  end

  private
  def create_params
    @group =Group.find(params[:group_id])
    params.require(:message).permit(:body, :image).merge(user_id: current_user.id, group_id: @group.id )
  end
end
