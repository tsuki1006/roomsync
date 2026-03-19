require 'rails_helper'

RSpec.describe 'Rooms', type: :request do
  let(:room) { create(:room) }
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET /rooms/:id' do
    context 'ルームに参加していないユーザーがルームのページを見ようとした場合' do
      it 'プロフィールページに遷移する' do
        get room_path(room)
        expect(response).to redirect_to(profile_path)
        expect(response).to have_http_status(302)
      end
    end
  end
end
