class InvoiceMailer < ApplicationMailer
  def invoice(bill)
    @bill = bill
    mail(to: bill.customer.email, subject: "Invoice ##{bill.id}")
  end
end
