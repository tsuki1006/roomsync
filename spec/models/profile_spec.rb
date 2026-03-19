require 'rails_helper'

RSpec.describe Profile, type: :model do

  it '必須項目が正常に入力されているときプロフィールを保存できる' do
    expect(build(:profile)).to be_valid
  end

  context 'nameがないとき' do
    let(:profile) { build(:profile, name: '') }

    before do
      profile.valid?
    end

    it '無効であること' do
      expect(profile.errors.of_kind?(:name, :blank)).to be true
    end
  end

  context 'nameが20文字を超えているとき' do
    let(:profile) { build(:profile, name: Faker::Lorem.characters(number: 21)) }

    before do
      profile.valid?
    end

    it '無効であること' do
      expect(profile.errors.of_kind?(:name, :too_long)).to be true
    end
  end

  context 'つぶやきが80文字を超えているとき' do
    let(:profile) { build(:profile, comment: Faker::Lorem.characters(number: 81)) }

    before do
      profile.valid?
    end

    it '無効であること' do
      expect(profile.errors.of_kind?(:comment, :too_long)).to be true
    end
  end

  context 'ユーザーに紐づいていないとき' do
    let(:profile) { build(:profile, user: nil) }

    before do
      profile.valid?
    end

    it '無効であること' do
      expect(profile.errors.of_kind?(:user, :blank)).to be true
    end
  end

  context 'プロフィールが既に存在しているとき' do
    let(:profile) { create(:profile) }
    let(:profile_second) { build(:profile, user: profile.user) }

    before do
      profile_second.valid?
    end

    it '無効であること' do
      expect(profile_second.errors.of_kind?(:user_id, :taken)).to be true
    end
  end
end
