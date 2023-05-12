require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "email、password、password_confirmation、nickname、sex_id、height_id、weight_idが存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it "height_idが未選択でも登録できる" do
        @user.height_id = '1'
        expect(@user).to be_valid
      end
      it "weight_idが未選択でも登録できる" do
        @user.weight_id = '1'
        expect(@user).to be_valid
      end
      it "height_idとweight_idが未選択でも登録できる" do
        @user.height_id = '1'
        @user.weight_id = '1'
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "すでに登録されているメールアドレスは登録できない" do
        @user.save
        another_user = FactoryBot.build(:user, email:@user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "＠が含まれていないと登録できない" do
        @user.email = "testtest"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordとpassword_confirmationが一致していないと登録できない" do
        @user.password = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "passwordが全角文字だと登録できない" do
        @user.password = "１２３４５６"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it "passwordが5文字以下だと登録できない" do
        @user.password = "12345"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "nickinameが空では登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "sex_idが未選択だと登録できない" do
        @user.sex_id = "1"
        @user.valid?
        expect(@user.errors.full_messages).to include("Sex can't be blank")
      end
    end

  end
end
