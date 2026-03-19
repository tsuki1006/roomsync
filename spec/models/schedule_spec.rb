require 'rails_helper'

RSpec.describe Schedule, type: :model do

  it '必須項目が正常に入力されているときスケジュールを作成できる' do
    expect(build(:schedule)).to be_valid
  end


  context 'start_timeががないとき' do
    let(:schedule) { build(:schedule, start_time: nil) }

    before do
      schedule.valid?
    end

    it '無効であること' do
      expect(schedule.errors.of_kind?(:start_time, :blank)).to be true
    end
  end


  context 'end_timeががないとき' do
    let(:schedule) { build(:schedule, end_time: nil) }

    before do
      schedule.valid?
    end

    it '無効であること' do
      expect(schedule.errors.of_kind?(:end_time, :blank)).to be true
    end
  end


  context 'end_timeがstart_timeよりも前のとき' do
    let(:schedule) { build(:schedule) }

    before do
      start = schedule.start_time
      schedule.end_time = start - 1.hour
      schedule.valid?
    end

    it '無効であること' do
      expect(schedule.errors[:end_time]).to include('は開始時間以降の時間を選択してください')
    end
  end


  context 'start_time現在のよりも前のとき' do
    let(:base_time) { Time.current.change(min: 0) }

    let(:schedule) do
      build(:schedule,
        start_time: base_time - 1.hour,
        end_time: base_time + 1.hour
      )
    end

    before do
      schedule.valid?
    end

    it '無効であること' do
      expect(schedule.errors[:start_time]).to include('は現在の日時以降の時間を選択してください')
    end
  end


  context '予定の期間が24時間を超えるとき' do
    let(:schedule) { build(:schedule) }

    before do
      start = schedule.start_time
      schedule.end_time = start + 1.day + 1.hour
      schedule.valid?
    end

    it '無効であること' do
      expect(schedule.errors[:end_time]).to include('は開始から24h以内に設定してください')
    end
  end


  context '同じ時間帯の時間帯が既に存在しているとき' do
    let(:schedule) { create(:schedule) }

    let(:duplicate_schedule) do
      build(:schedule,
        creator: schedule.creator,
        room: schedule.room,
        start_time: schedule.start_time + 30.minutes,
        end_time: schedule.end_time + 30.minutes
      )
    end

    before do
      duplicate_schedule.valid?
    end

    it '無効であること' do
      expect(duplicate_schedule.errors[:base]).to include('同じ時間帯に複数の予定を作成することはできません')
    end
  end


  context '時間が15分単位でないとき' do
    let(:schedule) do
      build(:schedule,
        start_time: Time.current.change(min:10) + 1.hour,
        end_time: Time.current.change(min:20) + 2.hour
      )
    end

    before do
      schedule.valid?
    end

    it '無効であること' do
      expect(schedule.errors[:base]).to include('時刻は15分単位で入力してください')
    end
  end
end
