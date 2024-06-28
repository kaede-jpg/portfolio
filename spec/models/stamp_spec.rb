require 'rails_helper'

RSpec.describe Stamp, type: :model do
  describe 'バリデーションチェック' do
    context '成功' do
      it '設定したすべてのバリデーションが機能しているか' do
        stamp = build(:stamp)
        expect(stamp).to be_valid
        expect(stamp.errors).to be_empty
      end
    end
    context '失敗' do
      context 'スタンプの画像が' do
        it '空欄の場合にバリデーションが機能してinvalidになるか' do
          stamp = build(:stamp)
          stamp.stamp_image = nil
          expect(stamp).to be_invalid
          expect(stamp.errors[:stamp_image]).to eq ['を入力してください']
        end
      end
    end
  end
end
