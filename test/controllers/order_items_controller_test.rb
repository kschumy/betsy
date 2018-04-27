require "test_helper"

describe OrderItemsController do
  describe "index" do
    it "should get index" do
      get order_items_path
      must_respond_with :success
    end

    it "succeeds when there are no order_items" do
      OrderItem.destroy_all
      get order_items_path
      must_respond_with :success
    end
  end

  describe "show" do

    it "succeeds for an existing order-item ID" do
      get order_item_path(OrderItem.first)
      must_respond_with :success
    end

    # it "renders 404 not_found for an invalid order_item ID" do
    #   invalid_order_item_id = OrderItem.last.id + 1
    #   get order_item_path(invalid_order_item_id)
    #   must_respond_with :not_found
    # end

  end

  describe "new" do
    it "should get new" do
      get new_order_item_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "should get created" do

      proc {
        post order_items_path,
        params: {
          order_item: {
            quantity: 4,
            price: 20,
            is_shipped: false,
            product_id: products(:ball).id,
            order_id: orders(:star_mouse_order).id,
          }
        }
      }.must_change "OrderItem.count", 1
      must_respond_with :redirect
      must_redirect_to view_cart_path
    end

    it "will not create with quantity missing" do
      proc {
        post order_items_path,
        params: {
          order_item: {
            price: 20,
            is_shipped: false,
            product_id: products(:ball).id,
            order_id: orders(:star_mouse_order).id,
          }
        }
      }.must_change "OrderItem.count", 0
      must_respond_with :redirect
    end
  end

  describe "edit" do
    it "should get edit" do
      get edit_order_item_path(OrderItem.first)
      must_respond_with :success
    end
  end

  describe "update" do
    it "should get updated" do



      order_item = OrderItem.first
      order_item_data = [
        order_item: {
          price: order_item.price + 1
        }
      ]

      # order_item.update(order_item_params)
      # must_redirect_to redirect_to order_items_path

      # OrderItem.find(order_item.id).price.must_equal order_item_data[:order_item][:price]
      # puts order_item_test.price += order_item_test.price + 1
      # put order_item_path order_items(order_item_test).id , params: {
      #   order_item_test: {
      #     quantity: original_quantity + 1
      #   }
      # }

    end
  end

  describe "destroy" do

    it "should get destroy and redirect to shopping cart if there are still items" do
      order_item_id = OrderItem.first.id
      delete order_item_path(order_item_id)

      must_redirect_to view_cart_path
      OrderItem.find_by(id: order_item_id).must_be_nil
    end

    it "should get destroy and redirect to root the cart becomes empty" do

    end

  end

  # private
  #
  # def order_item_params
  #   params.require(:order_item).permit(:quantity, :price, :is_shipped, :product_id, :order_id)
  # end
end
