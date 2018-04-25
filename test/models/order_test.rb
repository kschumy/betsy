require "test_helper"

describe Order do
  describe "valid" do
    let(:order) { orders(:user_mcuser_order) }
    let(:new_paid_order_hash) {
      { email_address: "starmouse@crater.com",
        cc_name: "Test Dummy",
        cc_number: 1234192910312811,
        cc_cvv: "201",
        cc_zip: "99503",
        status: "paid",
        customer_name: "Ada MarsFan",
        street: "123 Space Ave",
        city: "Seattle",
        state: "WA",
        mailing_zip: "98103",
        cc_exp_month: 12,
        cc_exp_year: 2050,
        order_items: []
      }
    }
      let(:new_item) {
        OrderItem.new(
          quantity: 10,
          price: 249,
          is_shipped: false,
          product: products(:ball),
          order: Order.new(status: "pending"))
      }

    it "must be valid" do
      order.must_be :valid?
    end

    # Valid customer_name ------------------------------------------------------
    it "must have at least one character in customer_name" do
      order.update!(status: "paid")

      order.customer_name = ""
      order.save
      order.valid?.must_equal false
      order.errors.must_include :customer_name

      order.customer_name =  "         "
      order.save
      order.valid?.must_equal false

      order.customer_name =  nil
      order.save
      order.valid?.must_equal false

      # Order.create().valid?.must_equal false
    end

    it "must have at least one character in customer_name" do
      # order.update!(status: "paid")

      order.customer_name = ""
      order.save
      order.valid?.must_equal true
      # order.errors.must_include :customer_name

      order.customer_name =  "         "
      order.save
      order.valid?.must_equal true

      order.customer_name =  nil
      order.save
      order.valid?.must_equal true

      # Order.create().valid?.must_equal false
    end
  end
end
    #   it "must have a unique name" do
    #     order = Order.create(name: orders(:novelty).name)
    #     order.valid?.must_equal false
    #     order.errors.must_include :name
    #   end
    #
    #   it "must have a unique name regardless of case" do
    #     new_cat_name = orders(:novelty).name
    #     new_cat_name[0] = new_cat_name.chr.swapcase
    #
    #     new_order = Order.create(name: new_cat_name)
    #     new_order.valid?.must_equal false
    #     new_order.errors.must_include :name
    #   end
    #
    #   it "removes strips white space from name" do
    #     new_order = Order.create(name: "     Hello      World     ")
    #     new_order.valid?.must_equal true
    #     new_order.name.must_equal "Hello World"
    #
    #   end
    #
    #   it "strips white space from name before testing validity" do
    #     Order.create(name: "Foo Bar      ").name.must_equal "Foo Bar"
    #
    #     # Should be invalid because whitespaces are removed and it's a duplicate
    #     new_order = Order.create(name: "Foo       Bar")
    #     new_order.valid?.must_equal false
    #     new_order.errors.must_include :name
    #
    #     # Should be invalid because whitespaces are removed and it's a duplicate
    #     new_order = Order.create(name: "     Foo Bar")
    #     new_order.valid?.must_equal false
    #     new_order.errors.must_include :name
    #   end
    # end
    #
    # describe "relations" do
    #   it "responds to products" do
    #     order = orders(:novelty)
    #     order.must_respond_to :products
    #     order.products.must_equal []
    #   end
    #
    #   it "can have products" do
    #     order = orders(:novelty)
    #     order.products << products(:ball)
    #
    #     order.products.must_include(products(:ball))
    #   end
    #
    #   it "must be added to product's list of orders" do
    #     product = products(:sweater)
    #     order = orders(:clothing)
    #     order.products << product
    #
    #     product.orders.must_include(order)
    #   end
    #
    #   it "can have multiple products" do
    #     order = orders(:novelty)
    #     order.products << products(:ball)
    #     order.products << products(:icecream)
    #
    #     order.products.must_equal [products(:ball), products(:icecream)]
    #   end
    #
    #   it "can be initialized with products" do
    #     new_order = Order.create(name: "foo", products: [products(:ball), products(:icecream)])
    #     new_order.valid?.must_equal true
    #   end

    # it "can be initialized with products" do
    #   # new_order = Order.new(name: "foo", products: [Date.today])
    #   # new_order.valid?.must_equal false
    #   new_order = Order.create(name: "foo")
    #   new_order.products << products(:icecream)
    #   new_order.add_product(Date.today)
    #
    #   new_order.products.must_equal [products(:icecream)]
    # end
