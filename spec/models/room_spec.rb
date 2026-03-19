require 'rails_helper'

RSpec.describe Room, type: :model do

  it '必須項目が正常に入力されているときルームを作成できる' do
    expect(build(:room)).to be_valid
  end

  context 'nameがないとき' do
    let(:room) { build(:room, name: '') }

    before do
      room.valid?
    end

    it '無効であること' do
      expect(room.errors.of_kind?(:name, :blank)).to be true
    end
  end

  context 'room_keyがないとき' do
    let(:room) { build(:room, room_key: '') }

    before do
      room.valid?
    end

    it '無効であること' do
      expect(room.errors.of_kind?(:room_key, :blank)).to be true
    end
  end

  context 'nameが50文字以上のとき' do
    let(:room) { build(:room, name: Faker::Lorem.characters(number: 51)) }

    before do
      room.valid?
    end

    it '無効であること' do
      expect(room.errors.of_kind?(:name, :too_long)).to be true
    end
  end

  context 'room_keyが6文字以下とき' do
    let(:room) { build(:room, room_key: Faker::Lorem.characters(number: 5)) }

    before do
      room.valid?
    end

    it '無効であること' do
      expect(room.errors.of_kind?(:room_key, :too_short)).to be true
    end
  end

  context 'ユーザーに紐づいていないとき' do
    let(:room) { build(:room, creator: nil) }

    before do
      room.valid?
    end

    it '無効であること' do
      expect(room.errors.of_kind?(:creator, :blank)).to be true
    end
  end

  context 'nameが既に存在しているとき' do
    let(:room) { create(:room) }
    let(:room_second) { build(:room, name: room.name) }

    before do
      room_second.valid?
    end

    it '無効であること' do
      expect(room_second.errors.of_kind?(:name, :taken)).to be true
    end
  end

  context 'ルームが存在するとき' do
    let(:room) { build(:room) }

    before do
      @key = room.room_key
      room.save
    end

    it '正しいroom_keyで認証できること' do
      expect(room.authenticate_room_key(@key)).to be room
    end
  end

  context 'ルームが存在するとき' do
    let(:room) { create(:room) }

    it '誤ったroom_keyでは認証できないこと' do
      expect(room.authenticate_room_key('password')).to be false
    end
  end
end
