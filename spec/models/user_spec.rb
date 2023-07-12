require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it '必要事項を全て過不足なく入力すると登録できる' do
        expect(@user).to be_valid
      end
      it 'パスワードが6文字以上半角英数字であれば登録できる' do
        @user.password = '123abc'
        @user.password_confirmation = '123abc'
        expect(@user).to be_valid
      end
      it '名字が全角（漢字・ひらがな・カタカナ）であれば登録できる' do
        @user.surname = '山田'
        expect(@user).to be_valid
      end
      it '名前が全角（漢字・ひらがな・カタカナ）であれば登録できる' do
        @user.given_name = '太郎'
        expect(@user).to be_valid
      end
      it '名字のフリガナが全角（カタカナ）であれば登録できる' do
        @user.surname_kana = 'ヤマダ'
        expect(@user).to be_valid
      end
      it '名前のフリガナが全角（カタカナ）であれば登録できる' do
        @user.given_name_kana = 'タロウ'
        expect(@user).to be_valid
      end
    end
    context '新規作成できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'emailが重複すると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailで@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが6文字未満では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordで半角英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        #@user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password 半角英数を両方含む必要があります")
      end

      it 'passwordで半角数字のみでは登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password 半角英数を両方含む必要があります")
      end

      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'ａａa １１1'
        @user.password_confirmation = 'ａａa １１1'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password 半角英数を両方含む必要があります")
      end

      it 'passwordとpassword_confirmationが一致しないと登録できない' do
        @user.password = 'aaa111'
        @user.password_confirmation = 'bbb111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'お名前(全角)は、名字が空では登録できない' do
        @user.surname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Surname can't be blank")
      end

      it 'お名前(全角)は、名前が空では登録できない' do
        @user.given_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Given name can't be blank")
      end

      it 'お名前(全角)は、名字を全角（漢字・ひらがな・カタカナ）で入力しないと登録できない' do
        @user.surname = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Surname is invalid")
      end

      it 'お名前(全角)は、名前を全角（漢字・ひらがな・カタカナ）で入力しないと登録できない' do
        @user.given_name = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Given name is invalid")
      end

      it 'お名前カナ(全角)は、名字が空では登録できない' do
        @user.surname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Surname kana can't be blank")
      end

      it 'お名前カナ(全角)は、名前が空では登録できない' do
        @user.given_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Given name kana can't be blank")
      end

      it 'お名前カナ(全角)は、名字を全角（カタカナ）で入力しないと登録できない' do
        @user.surname_kana = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Surname kana 全角カタカナのみで入力して下さい')
      end

      it 'お名前カナ(全角)は、名前を全角（カタカナ）で入力しないと登録できない' do
        @user.given_name_kana = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Given name kana 全角カタカナのみで入力して下さい')
      end
      it '生年月日が空だと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
