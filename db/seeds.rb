# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Seed Products
products_data = [
  {
    name: "Pen",
    product_code: "P001",
    stock: 100,
    price: 10.0,
    tax_percentage: 5.0
  },
  {
    name: "Notebook",
    product_code: "P002",
    stock: 50,
    price: 50.0,
    tax_percentage: 10.0
  },
  {
    name: "Pencil",
    product_code: "P003",
    stock: 200,
    price: 5.0,
    tax_percentage: 5.0
  },
  {
    name: "Eraser",
    product_code: "P004",
    stock: 150,
    price: 8.0,
    tax_percentage: 5.0
  },
  {
    name: "Ruler",
    product_code: "P005",
    stock: 75,
    price: 25.0,
    tax_percentage: 10.0
  },
  {
    name: "Sharpener",
    product_code: "P006",
    stock: 80,
    price: 15.0,
    tax_percentage: 5.0
  },
  {
    name: "Stapler",
    product_code: "P007",
    stock: 40,
    price: 120.0,
    tax_percentage: 12.0
  },
  {
    name: "Highlighter",
    product_code: "P008",
    stock: 90,
    price: 30.0,
    tax_percentage: 10.0
  },
  {
    name: "Marker",
    product_code: "P009",
    stock: 60,
    price: 35.0,
    tax_percentage: 10.0
  },
  {
    name: "Calculator",
    product_code: "P010",
    stock: 25,
    price: 500.0,
    tax_percentage: 18.0
  }
]

products_data.each do |product_attrs|
  Product.find_or_create_by!(product_code: product_attrs[:product_code]) do |product|
    product.name = product_attrs[:name]
    product.stock = product_attrs[:stock]
    product.price = product_attrs[:price]
    product.tax_percentage = product_attrs[:tax_percentage]
  end
end

# Seed Denominations
[2000, 500, 200, 100, 50, 20, 10].each do |v|
  Denomination.find_or_create_by!(value: v) do |denomination|
    denomination.available_count = 20
  end
end

  