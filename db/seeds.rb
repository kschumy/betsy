# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'csv'

CATEGORY_FILE = Rails.root.join('db', 'seed_data','categories_seeds.csv')

category_failures = []
CSV.foreach(CATEGORY_FILE, :headers => true) do |row|
  category = Category.new
  category.name = row['category']
  successeful = category.save
  if !successful
    category_failures << category
    puts "Failed to save category: #{category.inspect}"
  else
    puts "Created passenger: #{categorycategory.inspect}"
  end

  # data = Hash[row.headers.zip(row.fields)]
  # puts data
  # Category.create!(data)
end


merchant_list = [
  { username: "Apollo", email: "apollo@example.com", uid: 1, provider: "github" },
  { username: "barnards_star", email: "barnards_star@example.net", uid: 2, provider: "github" }
]

merchant_list.each do |merchant|
  new_merchant = Merchant.create(merchant)
end
#
# category_list = [
#   {name: "Novelty"},
#   {name: "Food"},
#   {name: "Scientific Method"},
#   {name: "Tools"},
# ]
#
# category_list.each do |category|
#   new_category = Category.create(category)
# end


product_list = [
  { name: "Pogo Stick", price: 1234, description: "Jump for miles", stock: 400, merchant_id: 1 , photo: "products/image_not_available.jpg"},
  { name: "Jump rope", price: 2345, description: "Jump for days", stock: 400, merchant_id: 1, photo: "products/image_not_available.jpg"},
  { name: "Telescope", price: 12048, description: "See for miles", stock: 400, merchant_id: 2, photo: "icons/telescope.png"}
]

product_list.each do |product|
  new_product = Product.create(product)
end

categories_products_list = [
  {product_id: 1, category_id: 1},
  {product_id: 2, category_id: 1},
  {product_id: 3, category_id: 3},
  {product_id: 4, category_id: 4},
]

category_list.each do |category|
  new_category = Category.create(category)
end

order_list = [
  {email_address: "Sara.Soehm@kuhic.com", cc_name: "Sara S", cc_number: 1234192910310395, cc_cvv: 111, cc_zip: 98191 , status: "paid", street: "11 Main Street", customer_name: "Sara S", city: "Tacoma", state: "WA", mailing_zip: 91891, cc_exp_month: 12, cc_exp_year: 2021 },
  {email_address: "Jo.Renner@gaylordkshlerin.net", cc_name: "Jo S", cc_number: 1234192910310393, cc_cvv: 222, cc_zip: 22222 , status: "complete", street: "22 Main Street", customer_name: "Jo S", city: "Junction City", state: "WA", mailing_zip: 92222, cc_exp_month: 12, cc_exp_year: 2022 },
  {email_address: "Lily.Rippin@wintheiser.info", cc_name: "Lily S", cc_number: 1234192910310311, cc_cvv: 333, cc_zip: 33333 , status: "pending", street: "33 Main Street", customer_name: "Lily S", city: "Lakeside", state: "WA", mailing_zip: 93333, cc_exp_month: 12, cc_exp_year: 2023 },
  {email_address: "Bling@kuhic.com", cc_name: "Bling S", cc_number: 1234192910320395, cc_cvv: 444, cc_zip: 44444 , status: "paid", street: "11 Main Street", customer_name: "Bling S", city: "Tacoma", state: "WA", mailing_zip: 91891, cc_exp_month: 12, cc_exp_year: 2021 },
  {email_address: "Candy@gaylordkshlerin.net", cc_name: "Candy S", cc_number: 1234292910310393, cc_cvv: 555, cc_zip: 55555 , status: "cancelled", street: "22 Main Street", customer_name: "Candy S", city: "Junction City", state: "WA", mailing_zip: 92222, cc_exp_month: 12, cc_exp_year: 2022 },
  {email_address: "Oreos@wintheiser.info", cc_name: "Oreos S", cc_number: 1234192910320311, cc_cvv: 666, cc_zip: 66666 , status: "pending", street: "33 Main Street", customer_name: "Oreo S", city: "Lakeside", state: "WA", mailing_zip: 93333, cc_exp_month: 12, cc_exp_year: 2023 },
  {email_address: "Plaintain@kuhic.com", cc_name: "Plaintain S", cc_number: 1234192912310395, cc_cvv: 777, cc_zip: 77777 , status: "complete", street: "11 Main Street", customer_name: "Plaintain S", city: "Tacoma", state: "WA", mailing_zip: 91891, cc_exp_month: 12, cc_exp_year: 2021 },
  {email_address: "Shoes@gaylordkshlerin.net", cc_name: "Shoe S", cc_number: 1234192920310393, cc_cvv: 888, cc_zip: 88888 , status: "paid", street: "22 Main Street", customer_name: "Shoe S", city: "Junction City", state: "WA", mailing_zip: 92222, cc_exp_month: 12, cc_exp_year: 2022 },
  {email_address: "Table@wintheiser.info", cc_name: "Table S", cc_number: 1234192920310311, cc_cvv: 999, cc_zip: 99999 , status: "pending", street: "33 Main Street", customer_name: "Table S", city: "Lakeside", state: "WA", mailing_zip: 93333, cc_exp_month: 12, cc_exp_year: 2023 }
]

order_list.each do |order|
  new_order = Order.create(order)
end

order_item_list = [
  {quantity: 1, price: 1234, is_shipped: false, product_id: 1, order_id: 1 },
  {quantity: 2, price: 2345, is_shipped: true, product_id: 2, order_id: 2 },
  {quantity: 3, price: 12048, is_shipped: false, product_id: 3, order_id: 3 },
  {quantity: 4, price: 1234, is_shipped: false, product_id: 1, order_id: 4 },
  {quantity: 5, price: 12048, is_shipped: false, product_id: 3, order_id: 5 },
  {quantity: 6, price: 2345, is_shipped: false, product_id: 2, order_id: 6 },
  {quantity: 7, price: 12048, is_shipped: true, product_id: 3, order_id: 7 },
  {quantity: 8, price: 2345, is_shipped: true, product_id: 2, order_id: 7 },
  {quantity: 9, price: 2345, is_shipped: false, product_id: 2, order_id: 8 },
  {quantity: 7, price: 1234, is_shipped: false, product_id: 1, order_id: 8 },
  {quantity: 8, price: 12048, is_shipped: false, product_id: 3, order_id: 9 },
  {quantity: 9, price: 2345, is_shipped: false, product_id: 2, order_id: 9 },
]

order_item_list.each do |item|
  new_item = OrderItem.create(item)
end
