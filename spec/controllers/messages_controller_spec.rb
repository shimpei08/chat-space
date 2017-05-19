require 'rails_helper' 

describe MessagesController do
  let(:message) { create(:message) }
  let(:group)   { create(:group) }
  let(:user)    { create(:user) }

  describe 'GET #new' do
    before do
      login_user user
    end

    before do
      get :new, params: { group_id: group.id }
    end
    it "populates an array of groups ordered by created_at desc " do
      groups = user.groups
      expect(assigns(:groups)).to match(groups.order("created_at DESC"))
    end

    it "assigns the requested group to @group" do
      expect(assigns(:group)).to eq group
    end

    it "populates an array of messages ordered by created_at desc" do
      messages = group.messages
      expect(assigns(:messages)).to match(messages.order("created_at DESC"))
    end

    it "renders the :new template" do
      expect(response).to render_template :new
    end

  end

  describe 'GET #index' do
    before do
      login_user user
    end

    it "populates an array of groups ordered by created_at desc " do
      groups = user.groups
      get :index
      expect(assigns(:groups)).to match(groups.sort{ |a,b| b.created_at <=> a.created_at })
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    before do
      login_user user
    end

    context "with valid attributes" do
      let(:message_params) { post :create, params: { message: attributes_for(:message), group_id: group.id } }
      it "saves the new message in the database" do
        expect{ message_params }.to change(Message, :count).by(1)
      end

      it "redirect to #new template" do
        message_params
        expect(response).to redirect_to new_group_message_url
      end
    end

    context "with invalid attributes" do
      let(:message_params) { post :create, params: {message: attributes_for(:message, { body: nil }), group_id: group.id } }
      it "can't save the new message in the database" do
        message_params
        expect{ message_params }.not_to change(Message, :count)
      end

      it "includes the flash message" do
        message_params
        expect(flash[:alert]).to include("メッセージを送信できませんでした")
      end

      it "redirect to #new template" do
      message_params
      expect(response).to redirect_to new_group_message_url
      end
    end
  end

end
