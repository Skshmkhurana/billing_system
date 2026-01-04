class Customer < ApplicationRecord
  has_many :bills
  validates :email, presence: true
end
