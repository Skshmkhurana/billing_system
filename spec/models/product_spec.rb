require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:product_code) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:tax_percentage) }
    it { should validate_presence_of(:stock) }
    it { should validate_uniqueness_of(:product_code) }
  end
end

