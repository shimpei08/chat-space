require 'rails_helper'
describe Message do
  let(:user)  { create(:user) }
  let(:group) { create(:group) }

  describe '#create' do
    it 'is valid with body, group_id, user_id' do
      message = build(:message, group_id: group.id, user_id: user.id)
      expect(message).to be_valid
    end

    it 'is invalid without a body' do
      message = build(:message, body: nil, group_id: group.id, user_id: user.id)
      message.valid?
      expect(message.errors[:body]).to include("を入力してください")
    end

    it "is invalid without a group" do
      message = build(:message, user_id: user.id, group_id: nil)
      message.valid?
      expect(message.errors[:group_id]).to include("を入力してください")
    end

    it "is invalid without a user" do
      message = build(:message, group_id: group.id, user_id: nil)
      message.valid?
      expect(message.errors[:user_id]).to include("を入力してください")
    end
  end
end
