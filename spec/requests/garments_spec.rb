require 'rails_helper'

RSpec.describe "Garments", type: :request do
  
  before do
    @garment = FactoryBot.create(:garment)
  end  

  describe "GET /garments" do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      username = ENV["BASIC_AUTH_USER"]
      password = ENV["BASIC_AUTH_PASSWORD"]
      get root_path, headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(username, password) }
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの洋服の画像が存在する' do 
      username = ENV["BASIC_AUTH_USER"]
      password = ENV["BASIC_AUTH_PASSWORD"]
      get root_path, headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(username, password) }
      expect(response.body).to include('test_image1.jpeg')
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの洋服のnameが存在する' do 
      username = ENV["BASIC_AUTH_USER"]
      password = ENV["BASIC_AUTH_PASSWORD"]
      get root_path, headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(username, password) }
      expect(response.body).to include(@garment.name)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの洋服のcategoryが存在する' do
      username = ENV["BASIC_AUTH_USER"]
      password = ENV["BASIC_AUTH_PASSWORD"]
      get root_path, headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(username, password) }
      expect(response.body).to include(@garment.category.name)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの洋服のbrandが存在する' do
      username = ENV["BASIC_AUTH_USER"]
      password = ENV["BASIC_AUTH_PASSWORD"]
      get root_path, headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(username, password) }
      expect(response.body).to include(@garment.brand)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの洋服の投稿者名が存在する' do
      username = ENV["BASIC_AUTH_USER"]
      password = ENV["BASIC_AUTH_PASSWORD"]
      get root_path, headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(username, password) }
      expect(response.body).to include(@garment.user.nickname)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する' do
      username = ENV["BASIC_AUTH_USER"]
      password = ENV["BASIC_AUTH_PASSWORD"]
      get root_path, headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(username, password) }
      expect(response.body).to include('Search')
    end
  end
end