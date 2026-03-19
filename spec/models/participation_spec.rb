require 'rails_helper'

RSpec.describe Participation, type: :model do

  context '既に予定に参加しているとき' do
    let(:participation) { create(:participation) }
    let(:double_participation) do
      build(:participation,
        user: participation.user,
        schedule: participation.schedule
      )
    end

    before do
      double_participation.valid?
    end

    it '無効であること' do
      expect(double_participation.errors).to be_present
    end
  end
end
