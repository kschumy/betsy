class Category < ApplicationRecord
  has_and_belongs_to_many :products

  # validates :name, presence: true, uniqueness: true

  before_validation :remove_white_space_from_name

  validates :name,  presence: true,
                    length: { minimum: 1 },
                    uniqueness: { case_sensitive: false }

  private

  def remove_white_space_from_name
    self.name.squish! if !self.name.nil?
  end
end
