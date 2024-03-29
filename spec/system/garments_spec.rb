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

RSpec.describe '投稿内容の編集', type: :system do
  before do
    @garment1 = FactoryBot.create(:garment)
    @garment2 = FactoryBot.create(:garment)
  end
  context '投稿編集ができるとき' do 
    it 'ログインしたユーザーは自分が投稿したツイートの編集ができる' do
      # @garment1を投稿したユーザーでログインする
      basic_pass new_user_session_path
      visit new_user_session_path
      fill_in 'メールアドレス', with: @garment1.user.email
      fill_in 'パスワード', with: @garment1.user.password
      find('input.btn-primary').click
      expect(current_path).to eq(root_path)
      # @garment1の詳細ページに遷移する
      visit garment_path(@garment1.id)
      expect(current_path).to eq(garment_path(@garment1.id))
      # 編集ページのボタンが存在する
      expect(page).to have_content('編集する')
      # 編集ページへ遷移する
      visit edit_garment_path(@garment1.id)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#garment_name').value
      ).to eq(@garment1.name)
      expect(
        find('#garment_genre_id').value
      ).to eq "#{@garment1.genre_id}"
      expect(
        find('#garment_category_id').value
      ).to eq "#{@garment1.category_id}"
      expect(
        find('#garment_brand').value
      ).to eq(@garment1.brand)
      expect(
        find('#garment_material').value
      ).to eq(@garment1.material)
      expect(
        find('#garment_size').value
      ).to eq(@garment1.size)
      expect(
        find('#garment_other').value
      ).to eq(@garment1.other)
      # 投稿内容を編集する
      image_path = Rails.root.join('public/images/test_image2.jpeg')
      attach_file('garment[image]', image_path, make_visible: true)
      fill_in 'garment_name', with: "#{@garment1.name}+abc"
      select 'キッズ', from: 'garment[genre_id]'
      select 'その他', from: 'garment[category_id]'
      fill_in 'garment_brand', with: "#{@garment1.brand}+abc"
      fill_in 'garment_material', with: "#{@garment1.material}+abc"
      fill_in 'garment_size', with: "#{@garment1.size}+abc"
      fill_in 'garment_other', with: "#{@garment1.other}+abc"
      # 編集してもGarmentモデルのカウントは変わらないことを確認する
      expect{
        find('input.btn-primary').click
      }.to change { Garment.count }.by(0)
      # 編集完了後、詳細ページに遷移する
      expect(current_path).to eq(garment_path(@garment1.id))
      # 先ほど変更した内容が存在することを確認する（image）
      expect(page).to have_selector("img[src$='test_image2.jpeg']")
      # 先ほど変更した内容が存在することを確認する（name）
      expect(page).to have_content("#{@garment1.name}+abc")
      # 先ほど変更した内容が存在することを確認する（genre.name）
      expect(page).to have_content("キッズ")
      # 先ほど変更した内容が存在することを確認する（category.name）
      expect(page).to have_content("その他")
      # 先ほど変更した内容が存在することを確認する（brand）
      expect(page).to have_content("#{@garment1.brand}+abc")
      # 先ほど変更した内容が存在することを確認する（material）
      expect(page).to have_content("#{@garment1.material}+abc")
      # 先ほど変更した内容が存在することを確認する（other）
      expect(page).to have_content("#{@garment1.other}+abc")
    end
  end
  context '投稿内容編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した洋服の編集画面には遷移できない' do
      # @garment1を投稿したユーザーでログインする
      basic_pass new_user_session_path
      visit new_user_session_path
      fill_in 'メールアドレス', with: @garment1.user.email
      fill_in 'パスワード', with: @garment1.user.password
      find('input.btn-primary').click
      expect(current_path).to eq(root_path)
      # @garment2の詳細ページに「編集」へのリンクがないことを確認する
      visit garment_path(@garment2.id)
      expect(page).to have_no_content('編集する')
    end
    it 'ログインしていないと洋服の編集画面には遷移できない' do
      # トップページにいる
      basic_pass root_path
      visit root_path
      # @garment1の詳細ページに「編集」へのリンクがないことを確認する
      visit garment_path(@garment1.id)
      expect(page).to have_no_content('編集する')
      # @garment2の詳細ページに「編集」へのリンクがないことを確認する
      visit garment_path(@garment2.id)
      expect(page).to have_no_content('編集する')
    end
  end
  RSpec.describe '投稿内容の削除', type: :system do
    before do
      @garment1 = FactoryBot.create(:garment)
      @garment2 = FactoryBot.create(:garment)
    end
    context '投稿内容が削除できるとき' do
      it 'ログインしたユーザーは自らが投稿した投稿内容を削除できる' do
        # garment1を投稿したユーザーでログインする
        basic_pass new_user_session_path
        visit new_user_session_path
        fill_in 'メールアドレス', with: @garment1.user.email
        fill_in 'パスワード', with: @garment1.user.password
        find('input.btn-primary').click
        expect(current_path).to eq(root_path)
        # garment1に「削除」へのリンクがあることを確認する
        # 投稿を削除するとレコードの数が1減ることを確認する
        # 削除完了後、TOPページに遷移したことを確認する
        # トップページに遷移する
        # トップページにはgarment1の内容が存在しないことを確認する（image）
        # トップページにはgarment1の内容が存在しないことを確認する（name）
        # トップページにはgarment1の内容が存在しないことを確認する（category.name）
        # トップページにはgarment1の内容が存在しないことを確認する（brand.name）
        # トップページにはgarment1の内容が存在しないことを確認する（user.nickname）
      end
    end
    context '投稿内容が削除ができないとき' do
      it 'ログインしたユーザーは自分以外が投稿した投稿の削除ができない' do
        # garment1を投稿したユーザーでログインする
        # garment2に「削除」へのリンクがないことを確認する
      end
      it 'ログインしていないと詳細ページに削除ボタンがない' do
        # トップページに移動する
        # garment1に「削除」へのリンクがないことを確認する
        # garment2に「削除」へのリンクがないことを確認する
      end
    end
end