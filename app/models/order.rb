class Order < ApplicationRecord
  has_many :order_items

  validates :email_address, presence: true
  validates_format_of :email_address, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  validates :mailing_address, presence: true
  validates :cc_name, presence: true
  validates :cc_number, presence: true
  validates :cc_exp, presence: true
  validates :cc_cvv, presence: true
  validates :cc_zip, presence: true
  validates :status, presence: true, inclusion: { in: %w(pending paid complete cancelled), message: "%{value} is not a valid status" }



end
