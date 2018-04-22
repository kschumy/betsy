class Product < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :reviews
  has_many :order_items
  belongs_to :merchant

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0.01 }
  validates :merchant, presence: true
 # validate should have minimum 1 category
  def inventory_status
    quantity = self.stock
    if quantity > 0
      return "In stock"
    else
      return "Out of stock"
    end
    # QUESTION: is it ok if we refactor this to the following?
    # return self.stock > 0 ? "In stock" : "Out of stock"
  end

end
