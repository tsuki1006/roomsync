# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# ダミーユーザーの作成
dummy_users = []
profile_data = [
  { name: 'Asahi@Java', introduction: '現在、異職種からエンジニアへの転職活動中🔥 ポートフォリオ制作に全力を注いでいます！', course: :java, comment: 'もうすぐデプロイ！🚀' },
  { name: 'Ren@2026.4~🔰', introduction: '最近Railsの学習を始めました！ 一歩ずつ頑張ります！💪🏻', course: :rails, comment: '毎日コツコツ継続中！🔥' },
  { name: 'ソウタ', introduction: 'Railsと最近はReact。モダンな技術を習得して、使いやすいUIを作るのが目標です✨ 基本もくもくしてますが、お話もOKです！', course: :rails, comment: 'Tailwind CSSにハマり中🎨' },
  { name: 'Shiori', introduction: 'Rails 7でアプリ開発中。日々エラーと戦ってます😂 みなさんにモチベもらって、地道にがんばります！', course: :rails, comment: '環境構築で詰まり中🌀' },
  { name: 'こはる@朝活☀️', introduction: '毎朝6時からプログラミングを学習しています。習慣化の力で基礎からしっかり身につけたいです！よければ一緒に朝活しましょう！', course: :java, comment: '朝活仲間、募集中です☀️' },
  { name: 'サクラ@週1投稿', introduction: 'QiitaやZennで日々の学習のアウトプットを継続しています。よければ読んでもらえると嬉しいです！', course: :other, comment: '質問・レビュー大歓迎です！🌸' }
]

6.times do |i|
  dummy = User.find_or_create_by!(email: "#{i + 1}@example.com") do |user|
    user.password = ENV['DUMMY_USER_PASSWORD']
  end
  dummy_users << dummy
  Profile.find_or_create_by!(user: dummy) do |p|
    data = profile_data[i]
    p.name = data[:name]
    p.introduction = data[:introduction]
    p.course = data[:course]
    p.comment = data[:comment]
    p.avatar.attach( io: File.open("lib/seeds/images/avatar_#{i}.png"), filename: "avatar_#{i}" )
  end
end

# ダミールームの作成
dummy_room = Room.find_or_create_by!(name: 'プログラミング学習室') do |room|
  room.creator = dummy_users.first
  room.room_key = SecureRandom.urlsafe_base64
  room.description = '一緒にプログラミングを学習しましょう！'
end

5.times do |i|
  UserRoom.find_or_create_by!( room: dummy_room, user: dummy_users[i + 1] )
end

# ゲストユーザーの作成
guest = User.find_or_create_by!(email: 'guest@example.com') do |user|
  user.password = SecureRandom.urlsafe_base64
end

Profile.find_or_create_by!(user: guest) do |p|
  p.name = 'ゲストユーザー'
  p.course = 'other'
  p.introduction = "ゲストユーザーとして一通りの機能をお試しいただけます😄\n※プロフィールの編集・ルームの参加はできません\n※データはログインのたびに初期化されます"
  p.comment = 'RoomSyncをお試しいただきありがとうございます✨'
  p.avatar.attach( io: File.open('lib/seeds/images/avatar_guest.png'), filename: 'avatar_guest' )
end

UserRoom.find_or_create_by!( room: dummy_room, user: guest )
