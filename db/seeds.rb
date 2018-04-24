# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'csv'

category_file = Rails.root.join('db', 'categories_seeds.csv')

category_failures = []
CSV.foreach(category_file, :headers => true) do |row|
  category = Category.new
  category.name = row['category']
  successful = category.save
  if !successful
    category_failures << category
    puts "Failed to save category: #{category.inspect}"
  else
    puts "Created passenger: #{category.inspect}"
  end
end

merchant_file = Rails.root.join('db', 'merchants_seeds.csv')
merchant_failures = []
i = 1
CSV.foreach(merchant_file, :headers => true) do |row|
  merchant = Merchant.new
  merchant.username = row['username']
  merchant.email = row['email']
  merchant.uid = i
  merchant.provider = "github"
  successful = merchant.save
  if !successful
    merchant_failures << merchant
    puts "Failed to save merchant: #{merchant.inspect}"
  else
    puts "Created merchant: #{merchant.inspect}"
  end
  i += 1
end


product_file = Rails.root.join('db', 'products_seeds.csv')
product_failures = []

CSV.foreach(product_file, :headers => true) do |row|
  product = Product.new
  product.name = row['name']
  product.price = row['price']
  product.description = row['description']
  product.stock = row['stock']
  product.discontinued = row['discontinued']
  product.photo = row['photo']
  product.merchant_id = row['merchant_id']
  successful = product.save
  if !successful
    product_failures << product
    puts "Failed to save product: #{product.inspect}"
  else
    puts "Created product: #{product.inspect}"
  end

end


categories_products_list = [
  {product_id: 1, category_id: 1},
  {product_id: 2, category_id: 1},
  {product_id: 3, category_id: 3},
  {product_id: 4, category_id: 4},
]

order_file = Rails.root.join('db', 'orders_seeds.csv')
order_failures = []

CSV.foreach(order_file, :headers => true) do |row|
  order = Order.new
  order.email_address = row['email_address']
  order.cc_name = row['cc_name']
  order.cc_number = row['cc_number']
  order.cc_cvv = row['cc_cvv']
  order.cc_zip = row['cc_zip']
  order.status = row['status']
  order.street = row['street']
  order.customer_name = row['customer_name']
  order.city = row['city']
  order.state = row['state']
  order.mailing_zip = row['mailing_zip']
  order.cc_exp_month = row['cc_exp_month']
  order.cc_exp_year = row['cc_exp_year']
  successful = order.save
  if !successful
    order_failures << order
    puts "Failed to save order: #{order.inspect}"
  else
    puts "Created order: #{order.inspect}"
  end

end

order_items_file = Rails.root.join('db', 'order_items_seeds.csv')
order_item_failures = []

CSV.foreach(order_items_file, :headers => true) do |row|
  order_item = OrderItem.new
  order_item.quantity = row['quantity']
  order_item.price = row['price']
  order_item.is_shipped = row['is_shipped']
  order_item.product_id = row['product_id']
  order_item.order_id = row['order_id']
  successful = order_item.save
  if !successful
    order_item_failures << order_item
    puts "Failed to save order_item: #{order_item.inspect}"
  else
    puts "Created order_item: #{order_item.inspect}"
  end
end

review_file = Rails.root.join('db', 'reviews_seeds.csv')
review_failures = []


CSV.foreach(review_file, :headers => true) do |row|
  review = Review.new
  review.rating = row['rating']
  review.comment = row['comment']
  review.product_id = row['product_id']
  successful = review.save
  if !successful
    review_failures << review
    puts "Failed to save review: #{review.inspect}"
  else
    puts "Created review: #{review.inspect}"
  end
end
