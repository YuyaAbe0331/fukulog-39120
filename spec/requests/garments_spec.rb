require 'rails_helper'

RSpec.describe "GarmentsController", type: :request do

  before do
    @garment = FactoryBot.create(:garment)
  end  

  describe "GET /garments" do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの洋服の画像が存在する' do 
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの洋服のnameが存在する' do 
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの洋服のcategoryが存在する' do 
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの洋服のbrandが存在する' do 
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの洋服の投稿者名が存在する' do 
    end
    it 'indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する' do 
    end
  end
end
