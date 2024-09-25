require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '全ての値が正常な場合、登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
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

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'abc123'
        @user.password_confirmation = 'def567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが数字だけでは登録できない' do
        @user = FactoryBot.build(:user, password: '000000', password_confirmation: '000000')
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end

      it 'passwordが英語だけでは登録できない' do
        @user = FactoryBot.build(:user, password: 'aaaaaa', password_confirmation: 'aaaaaa')
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end

      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'aaa０００'
        @user.password_confirmation = 'aaa０００'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
    end

    context 'last_nameのバリデーション' do
      it '全角（漢字・ひらがな・カタカナ）の入力で登録できる' do
        valid_last_names = ['山田', 'やまだ', 'ヤマダ'] # rubocop:disable Style/WordArray
        valid_last_names.each do |name|
          @user.last_name = name
          expect(@user).to be_valid
        end
      end

      it '全角（漢字・ひらがな・カタカナ）以外の入力は登録できない' do
        invalid_last_names = ['yamada', 'ﾔﾏﾀﾞ', '12345', '!@#$%']
        invalid_last_names.each do |name|
          @user.last_name = name
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name は全角（漢字・ひらがな・カタカナ）で入力してください')
        end
      end
    end

    context 'first_nameのバリデーション' do
      it '全角（漢字・ひらがな・カタカナ）の入力で登録できる' do
        valid_first_names = ['太郎', 'たろう', 'タロウ'] # rubocop:disable Style/WordArray
        valid_first_names.each do |name|
          @user.first_name = name
          expect(@user).to be_valid
        end
      end

      it '全角（漢字・ひらがな・カタカナ）以外の入力は登録できない' do
        invalid_first_names = ['taro', 'ﾀﾛｳ', '12345', '!@#$%']
        invalid_first_names.each do |name|
          @user.first_name = name
          @user.valid?
          expect(@user.errors.full_messages).to include('First name は全角（漢字・ひらがな・カタカナ）で入力してください')
        end
      end
    end

    context 'last_name_kanaのバリデーション' do
      it '全角カタカナの入力で登録できる' do
        valid_last_name_kanas = ['ヤマダ', 'タナカ'] # rubocop:disable Style/WordArray
        valid_last_name_kanas.each do |name|
          @user.last_name_kana = name
          expect(@user).to be_valid
        end
      end

      it '全角カタカナ以外の入力は登録できない' do
        invalid_last_name_kanas = ['やまだ', '山田', 'ﾔﾏﾀﾞ', 'YAMADA', '12345', '!@#$%']
        invalid_last_name_kanas.each do |name|
          @user.last_name_kana = name
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name kana は全角カタカナで入力してください')
        end
      end
    end

    context 'first_name_kanaのバリデーション' do
      it '全角カタカナの入力で登録できる' do
        valid_first_name_kanas = ['タロウ', 'ハナコ'] # rubocop:disable Style/WordArray
        valid_first_name_kanas.each do |name|
          @user.first_name_kana = name
          expect(@user).to be_valid
        end
      end

      it '全角カタカナ以外の入力は登録できない' do
        invalid_first_name_kanas = ['たろう', '太郎', 'ﾀﾛｳ', 'TARO', '12345', '!@#$%']
        invalid_first_name_kanas.each do |name|
          @user.first_name_kana = name
          @user.valid?
          expect(@user.errors.full_messages).to include('First name kana は全角カタカナで入力してください')
        end
      end
    end
  end
end
