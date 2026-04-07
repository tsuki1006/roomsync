require 'rails_helper'

RSpec.describe 'Schedules', type: :system, display: true do

  context 'ユーザーがログイン後スケジュールを作成すると' do
    let(:user) { create(:user, :with_profile) }
    let!(:room) { create( :room, creator: user) }

    before do
      sign_in user
      visit my_room_path
      click_on '入室する →'
      click_on '予定を作成'

      # スケジュール作成
      fill_in '開始日時', with: Time.new(2026, 04, 25, 9, 30)
      fill_in '終了日時', with: Time.new(2026, 04, 25, 12, 00)
      fill_in '一言コメント', with: 'Railsの勉強をします'
      click_on '予定を作成する'
    end

    it 'スケジュールが表示される' do
      expect(page).to have_current_path(room_path(room, format: :html), ignore_query: true)
      within '#day_calendar' do
        expect(page).to have_content '4/25の学習予定'
        expect(page).to have_content '9:30'
        expect(page).to have_content '12:00'
        expect(page).to have_content 'Railsの勉強をします'
        expect(page).to have_content user.name
      end
    end
  end
end
