class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  def get_order_items
    return find_order_items
  end

  def get_item_subtotal
    price * quantity
  end

  def get_order_status
    Order.find(order_id).status
    # order_id
    # order[self.order_id].status
  end

  def get_item_name
    Product.find(product_id).name
  end

  def get_item_merchant
    merchant_id = Product.find(product_id).merchant_id
    Merchant.find(merchant_id).username
  end

  def get_item_merchant_id
    merchant_id = Product.find(product_id).merchant_id
    Merchant.find(merchant_id).id
  end

  def shipping_status
    if is_shipped == false && get_order_status == "paid"
      shipping_status = "Ready to ship"
    elsif is_shipped == false
      shipping_status = "Not shipped"
    else is_shipped == false
      shipping_status = "Shipped"
    end
  end

  private

  def find_order_items
    return self.order_items
  end
end
