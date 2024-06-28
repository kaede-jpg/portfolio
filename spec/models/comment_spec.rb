require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'バリデーションチェック' do
    context '成功' do
      it '設定したすべてのバリデーションが機能しているか' do
        comment = build(:comment)
        expect(comment).to be_valid
        expect(comment.errors).to be_empty
      end
    end
    context '失敗' do
      context 'ユーザーが' do
        it '空欄の場合にバリデーションが機能してinvalidになるか' do
          comment = build(:comment, user_id: '')
          expect(comment).to be_invalid
          expect(comment.errors[:user]).to eq ['を入力してください']
        end
      end
      context '記録が' do
        it '空欄の場合にバリデーションが機能してinvalidになるか' do
          comment = build(:comment, record_id: '')
          expect(comment).to be_invalid
          expect(comment.errors[:record]).to eq ['を入力してください']
        end
      end
      context '本文が' do
        it '空欄の場合にバリデーションが機能してinvalidになるか' do
          comment = build(:comment, body: '')
          expect(comment).to be_invalid
          expect(comment.errors[:body]).to eq ['を入力してください']
        end
      end
    end
  end
end
