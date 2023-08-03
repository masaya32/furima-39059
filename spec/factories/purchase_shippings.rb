FactoryBot.define do
  factory :purchase_shippings do
    post_code { '123-1234'}
    prefecture_id { 3 }
    municipalities { '横浜市緑区' }
    address { '3-4' }
    building_name { '青山ビル' }
    phone_number { '09012341234' }
    token {"tok_abcdefghijk00000000000000000"}
    
    association :user_id
    association :item_id
  end
end