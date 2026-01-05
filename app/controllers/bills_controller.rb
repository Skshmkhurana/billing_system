class BillsController < ApplicationController
  def new
    @bill = Bill.new
    @denominations = Denomination.order(value: :desc)
  end

  def create
    customer = Customer.find_or_create_by!(email: params[:customer_email])

    @bill = customer.bills.create!(
      paid_amount: params[:paid_amount]
    )

    # Save products
    params[:bill_items].each do |item|
      product = Product.find_by!(product_code: item[:product_code])
      @bill.bill_items.create!(
        product: product,
        quantity: item[:quantity]
      )
    end

    # Update denomination availability from form
    params[:denominations].each do |id, count|
      Denomination.find(id).update!(available_count: count.to_i)
    end

    # Calculate bill
    BillingCalculator.new(@bill).call

    # Calculate balance (change to be given)
    balance = @bill.paid_amount - @bill.total_amount

    # Calculate change using AVAILABLE denominations (only if balance is positive)
    if balance > 0
      ChangeCalculator.new(balance).call(@bill)
    end

    SendInvoiceJob.perform_later(@bill.id)

    redirect_to bill_path(@bill)
  end

  def show
    @bill = Bill.includes(:bill_items, :payment_breakdowns).find(params[:id])
  end
end
