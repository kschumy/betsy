class Category < ApplicationRecord
  has_and_belongs_to_many :products

  # validates :name, presence: true, uniqueness: true

  before_validation :remove_white_space_from_name

  validates :name,  presence: true,
                    length: { minimum: 1 },
                    uniqueness: { case_sensitive: false }

  def add_product(new_product)
    # TODO add error throw
    self.products << new_product if new_product.is_a?(Product)
  end

  private

  def remove_white_space_from_name
    self.name.squish! if !self.name.nil?
  end
end
