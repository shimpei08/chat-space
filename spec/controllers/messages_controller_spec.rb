require 'rails_helper'
describe MessagesController do
  let(:message) { create(:message) }
  let(:group)   { create(:group)}
  let(:user)    { create(:user)}

  describe 'GET #new' do
    before do
      login_user user
    end

    it "populates an array of groups ordered by created_at desc " do
      groups = user.groups
      get :new , params: { group_id: group.id }
      expect(assigns(:groups)).to match(groups.sort{ |a,b| b.created_at <=> a.created_at })
    end

    it "assigns the requested group to @group" do
      get :new, params: { group_id:group.id }
      expect(assigns(:group)).to eq group
    end

    it "populates an array of messages ordered by created_at desc" do
      messages = group.messages
      get :new, params: {group_id: group.id}
      expect(assigns(:messages)).to match(messages.sort{ |a,b| b.created_at <=> a.created_at})
    end

    it "renders the :new template" do
      get :new, params: {group_id: group.id}
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
  end
end
