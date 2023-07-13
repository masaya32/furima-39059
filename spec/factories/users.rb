FactoryBot.define do
  factory :user do
    nickname {Faker::Name.name}
    email {Faker::Internet.unique.email}
    password { 'a1' + Faker::Internet.password(min_length: 6)}
    password_confirmation { password }
    surname   { 'やマ田' }
    given_name  { '太ろウ' }
    surname_kana  { 'ヤマダ' }
    given_name_kana { 'タロウ' }
    birthday { Faker::Date.birthday }
  end
end