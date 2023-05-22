require 'rails_helper'

def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end


RSpec.describe "Garments", type: :system do
  before do
    @user = FactoryBot.create(:user)
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
      # フォームに情報を入力する
      # 送信するとGarmentsモデルのカウントが1上がることを確認する
      # 投稿完了ページに遷移することを確認する
      # 「投稿が完了しました」の文字があることを確認する
      # トップページに遷移する
      # トップページには先ほど投稿した内容の洋服が存在することを確認する（image）
      # トップページには先ほど投稿した内容の洋服が存在することを確認する（name）
      # トップページには先ほど投稿した内容の洋服が存在することを確認する（category.name）
      # トップページには先ほど投稿した内容の洋服が存在することを確認する（brand）
      # トップページには先ほど投稿したユーザ名が表示されることを確認する（@user.name）
    end
  end
  context '洋服投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      # 新規投稿ページへのボタンがないことを確認する
    end
  end
end
