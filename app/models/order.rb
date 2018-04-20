class Order < ApplicationRecord
  has_many :order_items
  validates :customer_name, presence: true
  validates :email_address, presence: true
  # validation of email is not restricted, only requires @
  validates_format_of :email_address, :with => /@/
  validates :mailing_address, presence: true
  validates :cc_name, presence: true
  validates :cc_number, numericality: true, presence: true, length: { is: 16 }
  #TO DO JACKIE: FINISH VALIDATIONS BELOW
  validates :cc_exp, presence: true
  validates :cc_cvv, presence: true
  validates :cc_zip, presence: true
  validates :status, presence: true, inclusion: { in: %w(pending paid complete cancelled), message: "%{value} is not a valid status" }



end
