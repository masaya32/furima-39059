class Shipping < ApplicationRecord
  belongs_to :purchase
  
  attr_accessor :token
  validates :token, presence: true
end
