require 'rails_helper'

RSpec.describe User, type: :model do

  it 'すべての値が正常に入力されているときアカウントを保存できる' do
    expect(build(:user)).to be_valid
  end

  context 'emailが未入力のとき' do
    let(:user) { build(:user, email: '') }

    before do
      user.valid?
    end

    it '無効であること' do
      expect(user.errors.of_kind?(:email, :blank)).to be true
    end
  end

  context 'passwordが未入力のとき' do
    let(:user) { build(:user, password: '') }

    before do
      user.valid?
    end

    it '無効であること' do
      expect(user.errors.of_kind?(:password, :blank)).to be true
    end
  end

end
