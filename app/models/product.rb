class Product < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :reviews
  has_many :order_items
  belongs_to :merchant

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0.01 }
  validates :merchant, presence: true
  validates :photo, presence: true
  validates :stock, presence: true

  validates_length_of :category_ids, :minimum => 1
  def inventory_status
    return self.stock > 0 ? "In stock" : "Out of stock"
  end

  def get_average_rating
    sum = 0.0
    num = self.reviews.length
    self.reviews.each do |review|
      sum += review.rating
    end
    average = sum/num
    if average == 0 || average.nil? || average.nan?
      return "No reviews"
    else
      return "#{format("%.1f", average)} out of 5"
    end
  end

end
