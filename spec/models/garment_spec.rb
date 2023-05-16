require 'rails_helper'

RSpec.describe Garment, type: :model do
  before do
    @garment = FactoryBot.build(:garment)
  end

  describe '洋服投稿内容の保存' do
    context '洋服が投稿できる場合' do
      it 'image, name, genre_id, category_id, brand, material, size, otherが入力されていれば投稿できる' do
        expect(@garment).to be_valid
      end
      it 'materialが空でも投稿できる' do
        @garment.material = ''
        expect(@garment).to be_valid
      end
      it 'sizeが空でも投稿できる' do
        @garment.size = ''
        expect(@garment).to be_valid
      end
      it 'otherが空でも投稿できる' do
        @garment.other = ''
        expect(@garment).to be_valid
      end
    end
    context '洋服が投稿できない場合' do
      it 'imageが空だと投稿できない' do
        @garment.image = nil
        @garment.valid?
        expect(@garment.errors.full_messages).to include("Image can't be blank")
      end     
      it 'nameが空だと投稿できない' do
        @garment.name = ''
        @garment.valid?
        expect(@garment.errors.full_messages).to include("Name can't be blank")
      end
      it 'genre_idが1だと投稿できない' do
        @garment.genre_id = '1'
        @garment.valid?
        expect(@garment.errors.full_messages).to include("Genre can't be blank")
      end
      it 'category_idが1だと投稿できない' do
        @garment.category_id = '1'
        @garment.valid?
        expect(@garment.errors.full_messages).to include("Category can't be blank")
      end
      it 'brandが空だと投稿できない' do
        @garment.brand = ''
        @garment.valid?
        expect(@garment.errors.full_messages).to include("Brand can't be blank")
      end
      it 'userが紐づいていないと投稿できない' do
        @garment.user = nil
        @garment.valid?
        expect(@garment.errors.full_messages).to include("User must exist")
      end
    end
  end
end
