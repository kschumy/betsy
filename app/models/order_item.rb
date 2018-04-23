class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  def get_order_items
    return find_order_items
  end

  private

  def find_order_items
    return self.order_items
  end
end
