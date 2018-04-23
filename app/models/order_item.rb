class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  def get_order_items
    return find_order_items
  end

  def get_item_subtotal
    price * quantity
  end

  private

  def find_order_items
    return self.order_items
  end
end
