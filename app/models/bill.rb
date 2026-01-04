class Bill < ApplicationRecord
  belongs_to :customer
  has_many :bill_items, dependent: :destroy
  has_many :payment_breakdowns, dependent: :destroy

  accepts_nested_attributes_for :bill_items, allow_destroy: true
end
