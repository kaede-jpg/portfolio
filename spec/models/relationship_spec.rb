require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'バリデーションチェック' do
    context "成功" do
      it '設定したすべてのバリデーションが機能しているか' do
        relationship = build_stubbed(:relationship)
        expect(relationship).to be_valid
        expect(relationship.errors).to be_empty
      end
      it 'monitor_idとmonitored_idそれぞれやその組み合わせが、被らない場合にバリデーションエラーが起きないか'do
          relationship = create(:relationship)
          relationship_with_another_user = build_stubbed(:relationship)
          expect(relationship_with_another_user).to be_valid
          expect(relationship_with_another_user.errors).to be_empty
      end
    end
    context "失敗" do
      context "monitor_idが" do
        it '空欄の場合にバリデーションが機能してinvalidになるか'do
          relationship = build_stubbed(:relationship, monitor_id: "")
          expect(relationship).to be_invalid
          expect(relationship.errors[:monitor_id]).to eq ["can't be blank"]
        end
        it '被る場合にバリデーションが機能してinvalidになるか'do
          relationship = create(:relationship)
          relationship_with_duplicated_monitor = build(:relationship, monitor_id: relationship.monitor_id, monitored_id: create(:user).id)
          expect(relationship_with_duplicated_monitor).to be_invalid
          expect(relationship_with_duplicated_monitor.errors[:monitor_id]).to eq ["has already been taken"]
        end
        it 'monitored_idに既存の場合にバリデーションが機能してinvalidになるか'do
          relationship = create(:relationship)
          relationship_with_monitor_taken_as_monitored = build_stubbed(:relationship, monitor_id: relationship.monitored_id)
          expect(relationship_with_monitor_taken_as_monitored).to be_invalid
          expect(relationship_with_monitor_taken_as_monitored.errors[:monitor_id]).to eq [": 既に監視者に設定されています"]
        end
      end
      context "monitored_idが" do
        it '空欄の場合にバリデーションが機能してinvalidになるか'do
          relationship = build_stubbed(:relationship, monitored_id: "")
          expect(relationship).to be_invalid
          expect(relationship.errors[:monitored_id]).to eq ["can't be blank"]
        end
        it '3件以上と被る場合にバリデーションが機能してinvalidになるか'do
          relationship1 = create(:relationship)
          relationship2 = create(:relationship, monitored_id: relationship1.monitored_id)
          relationship3 = create(:relationship, monitored_id: relationship1.monitored_id)
          relationship_with_duplicated_3_monitored = build_stubbed(:relationship, monitored_id: relationship1.monitored_id)
          expect(relationship_with_duplicated_3_monitored).to be_invalid
          expect(relationship_with_duplicated_3_monitored.errors[:monitored_id]).to eq [": 監視者に設定できるのは、3名までです"]
        end
        it 'monitor_idに既存の場合にバリデーションが機能してinvalidになるか'do
          relationship = create(:relationship)
          relationship_with_monitored_taken_as_monitor = build_stubbed(:relationship, monitored_id: relationship.monitor_id)
          expect(relationship_with_monitored_taken_as_monitor).to be_invalid
          expect(relationship_with_monitored_taken_as_monitor.errors[:monitored_id]).to eq [": 既に監視される側に設定されています"]
        end
      end
    end
  end
end
