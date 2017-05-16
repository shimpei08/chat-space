require 'rails_helper'
describe Message do
  describe '#create' do
    it 'is valid with body, group_id, user_id' do
      user    = create(:user)
      group   = create(:group)
      message = build(:message, group_id: group.id, user_id: user.id)
      expect(message).to be_valid
    end

    it 'is invalid without a body' do
      user    = create(:user)
      group   = create(:group)
      message = build(:message, body: nil, group_id: group.id, user_id: user.id)
      message.valid?
      expect(message.errors[:body]).to include("を入力してください")
    end

    it "is invalid without a group" do
      user    = create(:user)
      message = build(:message, user_id: user.id, group_id: nil)
      message.valid?
      expect(message.errors[:group_id]).to include("を入力してください")
    end

    it "is invalid without a user" do
      group   = create(:group)
      message = build(:message, group_id: group.id, user_id: nil)
      message.valid?
      expect(message.errors[:user_id]).to include("を入力してください")
    end
  end
end
