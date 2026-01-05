class SendInvoiceJob < ApplicationJob
  queue_as :default

  def perform(bill_id)
    bill = Bill.find(bill_id)
    InvoiceMailer.invoice(bill).deliver_now
  end
end
