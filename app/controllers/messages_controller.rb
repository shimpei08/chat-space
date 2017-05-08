class MessagesController < ApplicationController

  def index
    @groups = current_user.groups.order('created_at DESC')
  end

  def new
    @groups = current_user.groups.order('created_at DESC')
    @group = Group.find(params[:group_id])
    @messages = @group.messages.order('created_at DESC')
    @message = Message.new
  end

  def create
    @message = current_user.messages.new(create_params)
    if @message.save
    flash[:notice] = "メッセージが送信されました"
    else
    flash[:alert] = "メッセージを送信できませんでした"
    end
    redirect_to new_group_message_path
  end

  private
  def create_params
    @group =Group.find(params[:group_id])
    params.require(:message).permit(:body, :image).merge( group_id: @group.id )
  end
end
