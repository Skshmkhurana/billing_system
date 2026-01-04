class Product < ApplicationRecord
    validates :name, :product_code, :price, :tax_percentage, :stock, presence: true
    validates :product_code, uniqueness: true
end
