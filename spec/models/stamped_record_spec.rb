require 'rails_helper'

RSpec.describe StampedRecord, type: :model do
  describe 'バリデーションチェック' do
    context '成功' do
      it '設定したすべてのバリデーションが機能しているか' do
        stamped_record = build_stubbed(:stamped_record)
        expect(stamped_record).to be_valid
        expect(stamped_record.errors).to be_empty
      end
    end
    context '失敗' do
      context '記録が' do
        it '空欄の場合にバリデーションが機能してinvalidになるか' do
          stamped_record = build(:stamped_record, record_id: '')
          expect(stamped_record).to be_invalid
          expect(stamped_record.errors[:record]).to eq ['を入力してください']
        end
      end
      context 'スタンプが' do
        it '空欄の場合にバリデーションが機能してinvalidになるか' do
          stamped_record = build(:stamped_record, stamp_id: '')
          expect(stamped_record).to be_invalid
          expect(stamped_record.errors[:stamp]).to eq ['を入力してください']
        end
      end
    end
  end
end
