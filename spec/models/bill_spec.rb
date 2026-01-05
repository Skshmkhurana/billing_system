require 'rails_helper'

RSpec.describe Bill, type: :model do
  describe 'associations' do
    it { should belong_to(:customer) }
    it { should have_many(:bill_items).dependent(:destroy) }
    it { should have_many(:products).through(:bill_items) }
  end

  describe 'validations' do
    # Add validations as needed
  end
end

