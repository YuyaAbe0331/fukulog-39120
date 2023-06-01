require 'rails_helper'

def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end


RSpec.describe "Garments", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @garment_name = Faker::Lorem.sentence
    @garment_brand = Faker::Lorem.sentence
    @garment_material = Faker::Lorem.paragraph
    @garment_size = Faker::Lorem.paragraph
    @garment_other = Faker::Lorem.paragraph
  end
  context '洋服投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      basic_pass new_user_session_path
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input.btn-primary').click
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_content('洋服を登録する')
      # 投稿ページに移動する
      visit new_garment_path
      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image1.jpeg')
      # フォームに情報を入力する
      attach_file('garment[image]', image_path, make_visible: true)
      fill_in '洋服名', with: @garment_name
      select 'レディース', from: 'garment[genre_id]'
      select 'Tシャツ', from: 'garment[category_id]'
      fill_in 'ブランド', with: @garment_brand
      fill_in '素材', with: @garment_material
      fill_in 'サイズ', with: @garment_size
      fill_in 'その他', with: @garment_other
      # 送信するとGarmentsモデルのカウントが1上がることを確認する
      expect{
        find('input.btn-primary').click
      }.to change { Garment.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(current_path).to eq(garments_path)
      # 「登録が完了しました！」の文字があることを確認する
      expect(page).to have_content('登録が完了しました！')
      # トップページに遷移する
      visit root_path
      # トップページには先ほど投稿した内容の洋服が存在することを確認する（image）
      expect(page).to have_selector("img[src$='test_image1.jpeg']")
      # トップページには先ほど投稿した内容の洋服が存在することを確認する（name）
      expect(page).to have_content(@garment_name)
      # トップページには先ほど投稿した内容の洋服が存在することを確認する（category.name）
      expect(page).to have_content('Tシャツ')
      # トップページには先ほど投稿した内容の洋服が存在することを確認する（brand）
      expect(page).to have_content(@garment_brand)
      # トップページには先ほど投稿したユーザ名が表示されることを確認する（@user.nickname）
      expect(page).to have_content(@user.nickname)
    end
  end
  context '洋服投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      basic_pass root_path
      visit root_path
      # 新規投稿ページへ遷移しようとするとログイン画面にリダイレクトする
      visit new_garment_path
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
