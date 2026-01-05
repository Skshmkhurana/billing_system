class ChangeCalculator
  def initialize(balance)
    @balance = balance.to_f
  end

  def call(bill)
    # Only calculate change if balance is positive
    return if @balance <= 0

    Denomination.order(value: :desc).each do |d|
      # Calculate how many of this denomination we can use
      # Use floor to ensure count is an integer
      max_count = (@balance / d.value).floor
      count = [max_count, d.available_count].min
      next if count <= 0

      PaymentBreakdown.create!(
        bill: bill,
        denomination: d,
        count: count
      )

      d.update!(available_count: d.available_count - count)
      @balance -= d.value * count
    end

    # Round to 2 decimal places to handle floating point precision issues
    @balance = @balance.round(2)
  end
end
