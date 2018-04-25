class Merchant < ApplicationRecord
  has_many :products

  # PRE: provided auth_hash must be a hash and have the key :info. Otherwise,
  # throws ArgumentError.
  # Returns a new instance of Merchant from provided auth_hash.
  def self.build_from_github(auth_hash)
    # valid_auth_hash_or_error(auth_hash)
    create_new_merchant(auth_hash)
  end

  def get_merchant_products
    Product.where(merchant_id: self.id)
  end

  def get_merchant_order_items
    OrderItem.where(product_id: self.get_merchant_products)
  end

  def get_merchant_orders
    order_ids = self.get_merchant_order_items.collect { |order_item| order_item.order_id }
    Order.where(:id => order_ids).where("orders.status = ? OR orders.status = ?", "paid","complete")
  end

  # def get_fulfillment_count
  #
  #   @orders.count
  # end

  private

  # Throw ArgumentError if provided auth_hash is not a hash or if it does not
  # have the key :info.
  def self.valid_auth_hash_or_error(auth_hash)
    # if !auth_hash.is_a?(OmniAuth::AuthHash) || !auth_hash.has(:info)
    raise ArgumentError.new("Invalid initial format from provider")
    # end
  end

  # PRE: provided auth_hash must be a hash and have the key :info.
  # Returns a new instance of Merchant, using the provided auth_hash to supply
  # provider, uid, email, and username.
  def self.create_new_merchant(auth_hash)
    return Merchant.new(
      provider: auth_hash[:provider],
      uid: auth_hash[:uid],
      email: auth_hash[:info][:email],
      username: get_valid_name(auth_hash[:info])
    )
  end

  def self.get_valid_name(auth_hash_info)
    if auth_hash_info[:name].nil? || auth_hash_info[:name].empty?
      return auth_hash_info[:nickname]
    else
      return  auth_hash_info[:name]
    end

  end

end
