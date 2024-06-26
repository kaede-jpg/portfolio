require 'rails_helper'

RSpec.describe Record, type: :model do
  describe 'バリデーションチェック' do
    context '成功' do
      it '設定したすべてのバリデーションが機能しているか' do
        record = build(:record)
        expect(record).to be_valid
        expect(record.errors).to be_empty
      end
    end
    context '失敗' do
      context 'ユーザーが' do
        it '空欄の場合にバリデーションが機能してinvalidになるか' do
          record = build(:record, user_id: '')
          expect(record).to be_invalid
          expect(record.errors[:user]).to eq ['を入力してください']
        end
      end
      context '食事の画像が' do
        it '空欄の場合にバリデーションが機能してinvalidになるか' do
          record = build(:record)
          record.meal_image = nil
          expect(record).to be_invalid
          expect(record.errors[:meal_image]).to eq ['を入力してください']
        end
      end
    end
  end
end
