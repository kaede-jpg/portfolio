require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションチェック' do
    context '成功' do
      it '設定したすべてのバリデーションが機能しているか' do
        user = build(:user)
        expect(user).to be_valid
        expect(user.errors).to be_empty
      end
      it 'メールアドレスが被らない場合にバリデーションエラーが起きないか' do
        create(:user)
        user_with_another_email = build(:user)
        expect(user_with_another_email).to be_valid
        expect(user_with_another_email.errors).to be_empty
      end
    end
    context '失敗' do
      context 'パスワードが' do
        it '3文字未満の場合にバリデーションが機能してinvalidになるか' do
          user = build(:user, password: 'aa', password_confirmation: 'aa')
          expect(user).to be_invalid
          expect(user.errors[:password]).to eq ['は3文字以上で入力してください']
        end
      end
      context 'パスワード確認が' do
        it '空欄の場合にバリデーションが機能してinvalidになるか' do
          user = build(:user, password: '', password_confirmation: '')
          expect(user).to be_invalid
          expect(user.errors[:password_confirmation]).to eq ['を入力してください']
        end
        it 'パスワードと不一致の場合にバリデーションが機能してinvalidになるか' do
          user = build(:user, password_confirmation: 'password2')
          expect(user).to be_invalid
          expect(user.errors[:password_confirmation]).to eq ['とパスワードの入力が一致しません']
        end
      end
      context 'メールアドレスが' do
        it '空欄の場合にバリデーションが機能してinvalidになるか' do
          user = build(:user, email: '')
          expect(user).to be_invalid
          expect(user.errors[:email]).to eq ['を入力してください']
        end
        it '被る場合にバリデーションが機能してinvalidになるか' do
          user_with_duplicated_email = build(:user, email: create(:user).email)
          expect(user_with_duplicated_email).to be_invalid
          expect(user_with_duplicated_email.errors[:email]).to eq ['はすでに存在します']
        end
      end
      context '名前が' do
        it '空欄の場合にバリデーションが機能してinvalidになるか' do
          user = build(:user, name: '')
          expect(user).to be_invalid
          expect(user.errors[:name]).to eq ['を入力してください']
        end
      end
    end
  end
end
