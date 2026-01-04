class PaymentBreakdown < ApplicationRecord
  belongs_to :bill
  belongs_to :denomination
end
