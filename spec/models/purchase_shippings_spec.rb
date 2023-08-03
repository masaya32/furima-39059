require 'rails_helper'

RSpec.describe Prefecture, type: :model do
  describe '商品購入記録の保存' do
    before do
       @user = FactoryBot.create(:user)
       @item = FactoryBot.create(:item)
       @purchase_shippings = FactoryBot.build(:purchase_shippings,user_id: @user.id, item_id: @item.id)
       sleep 0.1
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば購入できること' do
        expect(@purchase_shippings).to be_valid
      end
      it '建物名が空でも購入できること' do
        @purchase_shippings.building_name = ''
        expect(@purchase_shippings).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号は空では保存できないこと' do
        @purchase_shippings.post_code = ''
        @purchase_shippings.valid?
        expect(@purchase_shippings.errors.full_messages).to include("Post code can't be blank")
      end
      it '郵便番号は『３桁ハイフン４桁』半角英数字でないと保存できないこと' do
        @purchase_shippings.post_code = '123-123４'
        @purchase_shippings.valid?
        expect(@purchase_shippings.errors.full_messages).to include("Post code is invalid")
      end
      it '都道府県に「---」が選択されている場合は購入できないこと' do
        @purchase_shippings.prefecture_id = '1'
        @purchase_shippings.valid?
        expect(@purchase_shippings.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空だと購入できないこと' do
        @purchase_shippings.municipalities = ''
        @purchase_shippings.valid?
        expect(@purchase_shippings.errors.full_messages).to include("Municipalities can't be blank")
      end
      it '番地が空だと購入できないこと' do
        @purchase_shippings.address = ''
        @purchase_shippings.valid?
        expect(@purchase_shippings.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空だと購入できないこと' do
        @purchase_shippings.phone_number = nil
        @purchase_shippings.valid?
        expect(@purchase_shippings.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号が9桁以下だと購入できないこと' do
        @purchase_shippings.phone_number = '090123456'
        @purchase_shippings.valid?
        expect(@purchase_shippings.errors.full_messages).to include("Phone number is invalid")
      end
      it '電話番号が12桁以上だと購入できない' do
        @purchase_shippings.phone_number = '090123456789'
        @purchase_shippings.valid?
        expect(@purchase_shippings.errors.full_messages).to include("Phone number is invalid")
      end
      it '電話番号が半角数値でないと購入できないこと' do
        @purchase_shippings.phone_number = '０9012341234'
        @purchase_shippings.valid?
        expect(@purchase_shippings.errors.full_messages).to include("Phone number is invalid")
      end
      it 'tokenが空では購入できないこと' do
        @purchase_shippings.token = nil
        @purchase_shippings.valid?
        expect(@purchase_shippings.errors.full_messages).to include("Token can't be blank")
      end
      it 'user_idが紐づいていなければ購入できないこと' do
        @purchase_shippings.user_id = ''
        @purchase_shippings.valid?
        expect(@purchase_shippings.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが紐づいていなければ購入できないこと' do
        @purchase_shippings.item_id = ''
        @purchase_shippings.valid?
        expect(@purchase_shippings.errors.full_messages).to include("Item can't be blank")
      end

    end
  end
end
