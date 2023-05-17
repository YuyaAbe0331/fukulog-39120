require 'rails_helper'

  def basic_index_pass(pass)
    username = ENV["BASIC_AUTH_USER"]
    password = ENV["BASIC_AUTH_PASSWORD"]
    get root_path, headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(username, password) }
  end

  def basic_show_pass(pass)
    username = ENV["BASIC_AUTH_USER"]
    password = ENV["BASIC_AUTH_PASSWORD"]
    get garment_path(@garment), headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(username, password) }
  end

RSpec.describe "Garments", type: :request do
  
  before do
    @garment = FactoryBot.create(:garment)
  end  

  describe "GET /garments" do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      basic_index_pass root_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの洋服の画像が存在する' do 
      basic_index_pass root_path
      expect(response.body).to include('test_image1.jpeg')
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの洋服のnameが存在する' do 
      basic_index_pass root_path
      expect(response.body).to include(@garment.name)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの洋服のcategoryが存在する' do
      basic_index_pass root_path
      expect(response.body).to include(@garment.category.name)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの洋服のbrandが存在する' do
      basic_index_pass root_path
      expect(response.body).to include(@garment.brand)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの洋服の投稿者名が存在する' do
      basic_index_pass root_path
      expect(response.body).to include(@garment.user.nickname)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する' do
      basic_index_pass root_path
      expect(response.body).to include('Search')
    end
  end

  describe 'GET #show' do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
      basic_show_pass garment_path(@garment)
      expect(response.status).to eq 200
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みの洋服の画像が存在する' do 
      basic_show_pass garment_path(@garment)
      expect(response.body).to include('test_image1.jpeg')
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みの洋服のnameが存在する' do
      basic_show_pass garment_path(@garment)
      expect(response.body).to include(@garment.name)
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みの洋服のgenreが存在する' do 
      basic_show_pass garment_path(@garment)
      expect(response.body).to include(@garment.genre.name)
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みの洋服のcategoryが存在する' do 
      basic_show_pass garment_path(@garment)
      expect(response.body).to include(@garment.category.name)
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みの洋服のbrandが存在する' do 
      basic_show_pass garment_path(@garment)
      expect(response.body).to include(@garment.brand)
    end
    it 'showアクションにリクエストするとレスポンスに素材の項目が存在する' do 
      basic_show_pass garment_path(@garment)
      expect(response.body).to include('素材')
    end
    it 'showアクションにリクエストするとレスポンスにサイズの項目が存在する' do 
      basic_show_pass garment_path(@garment)
      expect(response.body).to include('サイズ')
    end
    it 'showアクションにリクエストするとレスポンスにその他の項目が存在する' do 
      basic_show_pass garment_path(@garment)
      expect(response.body).to include('その他')
    end
    it 'showアクションにリクエストするとレスポンスに投稿者名が存在する' do 
      basic_show_pass garment_path(@garment)
      expect(response.body).to include(@garment.user.nickname)
    end
  end 
end