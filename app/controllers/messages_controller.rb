class MessagesController < ApplicationController

  def index
    @groups = current_user.groups.desc
    binding.pry
  end

  def new
    @groups = current_user.groups.desc
    @group = Group.find(params[:group_id])
    @messages = @group.messages.desc
    @message = Message.new
  end

  def create
    @message = current_user.messages.new(create_params)
    if @message.save
      respond_to do |format|
        format.json { render json: message_js(@message) }
      end
    else
      redirect_to new_group_message_url, alert: 'メッセージを送信できませんでした'
    end
  end

  private

  def message_js(message)
    hash = {
      name: message.user.name,
      created_at: refine_time(message),
      body: message.body,
      id: message.id
    }
  end

  def refine_time(time)
    time.created_at.strftime("%Y/%m/%d/%H:%M:%S")
  end


  def create_params
    params.require(:message).permit(:body, :image).merge( group_id: params[:group_id] )
  end
end
