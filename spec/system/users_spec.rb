require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }
  before do
    driven_by(:rack_test)
  end

  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      context 'フォームの入力値が正常' do
        it 'アクティベーションメールの送信が成功する' do
          
        end
      end
      context '名前が空欄' do
        it 'ユーザーの新規作成が失敗する' do
          
        end
      end
      context 'メールアドレスが未入力' do
        it 'ユーザーの新規作成が失敗する' do
          
        end
      end
      context '登録済のメールアドレスを使用' do
        it 'ユーザーの新規作成が失敗する' do
          
        end
      end
      context 'パスワードが3文字未満' do
        it 'ユーザーの新規作成が失敗する' do
          
        end
      end
      context 'パスワード確認が空欄' do
        it 'ユーザーの新規作成が失敗する' do
          
        end
      end
      context 'パスワードとパスワード確認が不一致' do
        it 'ユーザーの新規作成が失敗する' do
          
        end
      end
    end

    describe 'ユーザーアクティベーション' do
      context '登録後にURLにアクセス' do
        it 'ユーザーの新規作成が成功する' do
          
        end
      end
    end

    describe 'ページ遷移' do
      context 'ユーザー情報ページ' do
        it 'アクセスが失敗する' do
         
        end
      end
      context 'ユーザー編集ページ' do
        it 'アクセスが失敗する' do
          
        end
      end
    end
  end

  describe 'ログイン後' do
    before { feature_login_as(user) }

    describe 'ユーザー情報' do
      it 'ログイン中のユーザー情報が表示される' do
        
      end
    end
    describe 'ユーザー編集' do
      context 'メールアドレスを変更 フォームの入力値が正常' do
        it 'アクティベーションメールの送信が成功する' do
          
        end
      end

      context 'メールアドレス以外を変更 フォームの入力値が正常' do
        it 'ユーザーの編集が成功する' do
          
        end
      end

      context 'メールアドレスが未入力' do
        it 'ユーザーの編集が失敗する' do
          
        end
      end

      context '登録済のメールアドレスを使用' do
        it 'ユーザーの編集が失敗する' do
          
        end
      end

      context 'パスワードが3文字未満' do
        it 'ユーザーの編集が失敗する' do
          
        end
      end

      context 'パスワード確認が空欄' do
        it 'ユーザーの編集が失敗する' do
          
        end
      end

      context 'パスワードとパスワード確認が不一致' do
        it 'ユーザーの編集が失敗する' do
          
        end
      end
    end
    describe 'ユーザーアクティベーション' do
      context '編集後にURLにアクセス' do
        it 'ユーザーの編集が成功する' do
          
        end
      end
    end
    describe 'ユーザー削除' do
      it 'ユーザーの削除が成功する' do
        
      end
    end
  end
end
