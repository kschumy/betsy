class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  # before_validation(on: :save) do
  #   Order.new
  # end
  validates :quantity, presence: true, numericality: { only_integer: true }
  validate :quantity_limits

  # TODO: needs validations!
  def quantity_limits
    available_quantity = product.stock
    if quantity.to_i > available_quantity
      errors.add(:quantity, "Only #{product.stock} are available")
    end
  end

  def get_subtotal
    price * quantity
  end

  def get_subtotal_to_string
    return get_subtotal
  end

  def get_order_status
    Order.find(order_id).status
  end

  def get_item_name
    Product.find(product_id).name
  end

  def get_item_merchant
    return product.merchant.username
  end

  def get_item_merchant_id
    return product.merchant.id
  end

  def shipping_status
    # TODO: review the logic on this when all logic is figured out. Also, our
    # logic currently has a 'complete' mean that the order has shipped. But does
    # this makes sense if merchants can mark individual order_items as shipped?
    if is_shipped == false && get_order_status == "paid"
      shipping_status = "Ready to ship"
    elsif is_shipped == false
      shipping_status = "Not shipped"
    else is_shipped == false
      shipping_status = "Shipped"
    end
    # Possible refactor:
    # if is_shipped
    #   return "Shipped"
    # else
    #   return get_order_status == "paid" ? "Ready to ship" : "Not ready to ship"
    # end
  end

  # def table_view
  #   if table_order_items == @order.order_items
  #     table_view = "Order view"
  #   elsif table_order_items == @merchant.order_items
  #     table_view = "Merchant view"
  #   else
  #     table_view = "Item view"
  #   end
  # end

  private

end
