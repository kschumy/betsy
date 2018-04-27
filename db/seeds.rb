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
    puts "Created category: #{category.inspect}"
  end
end

merchant_file = Rails.root.join('db', 'merchants_seeds.csv')
merchant_failures = []
i = 100000
CSV.foreach(merchant_file, :headers => true) do |row|
  merchant = Merchant.new
  merchant.username = row['username']
  merchant.email = row['email']
  if row['uid'] != nil
    merchant.uid = row['uid']
  else
    merchant.uid = i
  end
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


prd = Product.find(1); cat=Category.find(1); prd.categories << cat
prd = Product.find(1); cat=Category.find(7); prd.categories << cat
prd = Product.find(2); cat=Category.find(3); prd.categories << cat
prd = Product.find(3); cat=Category.find(3); prd.categories << cat
prd = Product.find(4); cat=Category.find(7); prd.categories << cat
prd = Product.find(4); cat=Category.find(9); prd.categories << cat
prd = Product.find(5); cat=Category.find(1); prd.categories << cat
prd = Product.find(5); cat=Category.find(3); prd.categories << cat
prd = Product.find(6); cat=Category.find(1); prd.categories << cat
prd = Product.find(7); cat=Category.find(8); prd.categories << cat
prd = Product.find(8); cat=Category.find(7); prd.categories << cat
prd = Product.find(8); cat=Category.find(9); prd.categories << cat
prd = Product.find(9); cat=Category.find(9); prd.categories << cat
prd = Product.find(10); cat=Category.find(3); prd.categories << cat
prd = Product.find(10); cat=Category.find(9); prd.categories << cat
prd = Product.find(11); cat=Category.find(6); prd.categories << cat
prd = Product.find(11); cat=Category.find(11); prd.categories << cat
prd = Product.find(12); cat=Category.find(1); prd.categories << cat
prd = Product.find(12); cat=Category.find(9); prd.categories << cat
prd = Product.find(13); cat=Category.find(1); prd.categories << cat
prd = Product.find(13); cat=Category.find(7); prd.categories << cat
prd = Product.find(14); cat=Category.find(9); prd.categories << cat
prd = Product.find(15); cat=Category.find(7); prd.categories << cat
prd = Product.find(15); cat=Category.find(9); prd.categories << cat
prd = Product.find(16); cat=Category.find(1); prd.categories << cat
prd = Product.find(16); cat=Category.find(8); prd.categories << cat
prd = Product.find(17); cat=Category.find(8); prd.categories << cat
prd = Product.find(18); cat=Category.find(2); prd.categories << cat
prd = Product.find(19); cat=Category.find(3); prd.categories << cat
prd = Product.find(20); cat=Category.find(5); prd.categories << cat
prd = Product.find(21); cat=Category.find(3); prd.categories << cat
prd = Product.find(21); cat=Category.find(8); prd.categories << cat
prd = Product.find(22); cat=Category.find(7); prd.categories << cat
prd = Product.find(22); cat=Category.find(9); prd.categories << cat
prd = Product.find(23); cat=Category.find(12); prd.categories << cat
prd = Product.find(24); cat=Category.find(7); prd.categories << cat
prd = Product.find(25); cat=Category.find(1); prd.categories << cat
prd = Product.find(25); cat=Category.find(8); prd.categories << cat
prd = Product.find(26); cat=Category.find(3); prd.categories << cat
prd = Product.find(26); cat=Category.find(8); prd.categories << cat
prd = Product.find(27); cat=Category.find(9); prd.categories << cat
prd = Product.find(28); cat=Category.find(5); prd.categories << cat
prd = Product.find(29); cat=Category.find(1); prd.categories << cat
prd = Product.find(29); cat=Category.find(5); prd.categories << cat
prd = Product.find(30); cat=Category.find(4); prd.categories << cat
prd = Product.find(31); cat=Category.find(4); prd.categories << cat
prd = Product.find(32); cat=Category.find(7); prd.categories << cat
prd = Product.find(33); cat=Category.find(6); prd.categories << cat
prd = Product.find(33); cat=Category.find(10); prd.categories << cat
prd = Product.find(34); cat=Category.find(6); prd.categories << cat
prd = Product.find(35); cat=Category.find(9); prd.categories << cat
prd = Product.find(36); cat=Category.find(8); prd.categories << cat
prd = Product.find(37); cat=Category.find(7); prd.categories << cat
prd = Product.find(37); cat=Category.find(9); prd.categories << cat
prd = Product.find(38); cat=Category.find(1); prd.categories << cat
prd = Product.find(38); cat=Category.find(8); prd.categories << cat
prd = Product.find(39); cat=Category.find(10); prd.categories << cat
prd = Product.find(40); cat=Category.find(3); prd.categories << cat
prd = Product.find(41); cat=Category.find(9); prd.categories << cat
prd = Product.find(42); cat=Category.find(12); prd.categories << cat
prd = Product.find(43); cat=Category.find(3); prd.categories << cat
prd = Product.find(44); cat=Category.find(1); prd.categories << cat
prd = Product.find(44); cat=Category.find(9); prd.categories << cat
prd = Product.find(45); cat=Category.find(1); prd.categories << cat
prd = Product.find(46); cat=Category.find(10); prd.categories << cat
prd = Product.find(47); cat=Category.find(9); prd.categories << cat
prd = Product.find(48); cat=Category.find(1); prd.categories << cat
prd = Product.find(48); cat=Category.find(3); prd.categories << cat
prd = Product.find(49); cat=Category.find(6); prd.categories << cat
prd = Product.find(49); cat=Category.find(12); prd.categories << cat
prd = Product.find(50); cat=Category.find(3); prd.categories << cat
prd = Product.find(51); cat=Category.find(7); prd.categories << cat
prd = Product.find(51); cat=Category.find(9); prd.categories << cat
prd = Product.find(52); cat=Category.find(11); prd.categories << cat
prd = Product.find(52); cat=Category.find(12); prd.categories << cat
prd = Product.find(53); cat=Category.find(1); prd.categories << cat
prd = Product.find(53); cat=Category.find(3); prd.categories << cat
prd = Product.find(54); cat=Category.find(7); prd.categories << cat
prd = Product.find(55); cat=Category.find(1); prd.categories << cat
prd = Product.find(55); cat=Category.find(6); prd.categories << cat
prd = Product.find(56); cat=Category.find(6); prd.categories << cat
prd = Product.find(57); cat=Category.find(12); prd.categories << cat
prd = Product.find(58); cat=Category.find(12); prd.categories << cat
prd = Product.find(59); cat=Category.find(12); prd.categories << cat
prd = Product.find(60); cat=Category.find(12); prd.categories << cat
prd = Product.find(61); cat=Category.find(11); prd.categories << cat
prd = Product.find(61); cat=Category.find(12); prd.categories << cat
prd = Product.find(62); cat=Category.find(8); prd.categories << cat
prd = Product.find(62); cat=Category.find(12); prd.categories << cat
prd = Product.find(63); cat=Category.find(8); prd.categories << cat
prd = Product.find(63); cat=Category.find(12); prd.categories << cat
prd = Product.find(64); cat=Category.find(12); prd.categories << cat
prd = Product.find(65); cat=Category.find(11); prd.categories << cat
prd = Product.find(65); cat=Category.find(12); prd.categories << cat
prd = Product.find(66); cat=Category.find(7); prd.categories << cat
prd = Product.find(66); cat=Category.find(12); prd.categories << cat
prd = Product.find(67); cat=Category.find(11); prd.categories << cat
prd = Product.find(67); cat=Category.find(12); prd.categories << cat
prd = Product.find(68); cat=Category.find(11); prd.categories << cat
prd = Product.find(68); cat=Category.find(12); prd.categories << cat
prd = Product.find(69); cat=Category.find(12); prd.categories << cat
prd = Product.find(70); cat=Category.find(12); prd.categories << cat
prd = Product.find(71); cat=Category.find(12); prd.categories << cat
prd = Product.find(72); cat=Category.find(8); prd.categories << cat
prd = Product.find(72); cat=Category.find(12); prd.categories << cat
prd = Product.find(73); cat=Category.find(12); prd.categories << cat
prd = Product.find(74); cat=Category.find(2); prd.categories << cat
prd = Product.find(74); cat=Category.find(12); prd.categories << cat
prd = Product.find(75); cat=Category.find(2); prd.categories << cat
prd = Product.find(75); cat=Category.find(12); prd.categories << cat
prd = Product.find(76); cat=Category.find(8); prd.categories << cat
prd = Product.find(76); cat=Category.find(12); prd.categories << cat
prd = Product.find(77); cat=Category.find(8); prd.categories << cat
prd = Product.find(77); cat=Category.find(12); prd.categories << cat
prd = Product.find(78); cat=Category.find(2); prd.categories << cat
prd = Product.find(78); cat=Category.find(12); prd.categories << cat
prd = Product.find(79); cat=Category.find(12); prd.categories << cat
prd = Product.find(80); cat=Category.find(12); prd.categories << cat
prd = Product.find(81); cat=Category.find(12); prd.categories << cat
prd = Product.find(82); cat=Category.find(12); prd.categories << cat
prd = Product.find(83); cat=Category.find(12); prd.categories << cat
prd = Product.find(84); cat=Category.find(8); prd.categories << cat
prd = Product.find(84); cat=Category.find(12); prd.categories << cat
prd = Product.find(85); cat=Category.find(8); prd.categories << cat
prd = Product.find(85); cat=Category.find(12); prd.categories << cat
prd = Product.find(86); cat=Category.find(12); prd.categories << cat
prd = Product.find(87); cat=Category.find(2); prd.categories << cat
prd = Product.find(87); cat=Category.find(12); prd.categories << cat
prd = Product.find(88); cat=Category.find(2); prd.categories << cat
prd = Product.find(88); cat=Category.find(12); prd.categories << cat
prd = Product.find(89); cat=Category.find(12); prd.categories << cat
prd = Product.find(90); cat=Category.find(2); prd.categories << cat
prd = Product.find(90); cat=Category.find(12); prd.categories << cat
prd = Product.find(91); cat=Category.find(12); prd.categories << cat
prd = Product.find(92); cat=Category.find(12); prd.categories << cat
prd = Product.find(93); cat=Category.find(12); prd.categories << cat
prd = Product.find(94); cat=Category.find(11); prd.categories << cat
prd = Product.find(94); cat=Category.find(12); prd.categories << cat
prd = Product.find(95); cat=Category.find(8); prd.categories << cat
prd = Product.find(95); cat=Category.find(12); prd.categories << cat
prd = Product.find(96); cat=Category.find(2); prd.categories << cat
prd = Product.find(96); cat=Category.find(12); prd.categories << cat
prd = Product.find(97); cat=Category.find(8); prd.categories << cat
prd = Product.find(97); cat=Category.find(12); prd.categories << cat
prd = Product.find(98); cat=Category.find(2); prd.categories << cat
prd = Product.find(98); cat=Category.find(12); prd.categories << cat
prd = Product.find(99); cat=Category.find(2); prd.categories << cat
prd = Product.find(99); cat=Category.find(12); prd.categories << cat
prd = Product.find(100); cat=Category.find(8); prd.categories << cat
prd = Product.find(100); cat=Category.find(12); prd.categories << cat
prd = Product.find(101); cat=Category.find(12); prd.categories << cat
prd = Product.find(102); cat=Category.find(7); prd.categories << cat
prd = Product.find(102); cat=Category.find(12); prd.categories << cat
prd = Product.find(103); cat=Category.find(2); prd.categories << cat
prd = Product.find(103); cat=Category.find(12); prd.categories << cat
prd = Product.find(104); cat=Category.find(12); prd.categories << cat
prd = Product.find(105); cat=Category.find(12); prd.categories << cat
prd = Product.find(106); cat=Category.find(4); prd.categories << cat
prd = Product.find(106); cat=Category.find(12); prd.categories << cat
prd = Product.find(107); cat=Category.find(2); prd.categories << cat
prd = Product.find(107); cat=Category.find(12); prd.categories << cat
