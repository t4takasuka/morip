require 'rails_helper'
describe User do
  describe '#create' do
    it "nameがないと登録できないこと" do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("が入力されていません。")
    end

    it "emailがないと登録できないこと" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("が入力されていません。")
    end
  end
end