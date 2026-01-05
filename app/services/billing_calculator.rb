class BillingCalculator
  def initialize(bill)
    @bill = bill
  end

  def call
    total = 0

    @bill.bill_items.each do |item|
      product = item.product

      tax = (product.price * product.tax_percentage / 100) * item.quantity
      subtotal = (product.price * item.quantity) + tax

      item.unit_price = product.price
      item.tax_amount = tax
      item.save!

      product.update!(stock: product.stock - item.quantity)

      total += subtotal
    end

    @bill.update!(total_amount: total)
  end
end
