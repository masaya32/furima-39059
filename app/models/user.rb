class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: '半角英数を両方含む必要があります'}

  validates :nickname, presence: true
  validates :surname, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/}
  validates :given_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/}
  validates :surname_kana, presence: true, format: {with: /\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/,message: '全角カタカナのみで入力して下さい'}
  validates :given_name_kana, presence: true, format: {with: /\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/,message: '全角カタカナのみで入力して下さい'}
  validates :birthday, presence: true
       
end

