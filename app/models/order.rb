class Order < ApplicationRecord
  has_many :order_items

  validates :customer_name, presence: true
  validates :email_address, presence: true
  # validation of email is not restricted, only requires @
  validates_format_of :email_address, :with => /@/
  validates :cc_name, presence: true
  validates :cc_number, numericality: true, presence: true, length: { is: 16 }
  validates :cc_cvv, presence: true, numericality: true, length: { is: 3 }
  validates :cc_zip, numericality: true, presence: true, length: { minimum: 5 }
  validates :street, presence: true
  validates :customer_name, presence: true
  validates :city, presence: true
  validates :state, presence:true, inclusion: { in: :state_array, message: "%{value} is not a valid state"}
  validates :mailing_zip, numericality: true, presence: true, length: { minimum: 5 }

  validates :cc_exp_month, presence: true, numericality: { only_integer: true, in: 1..12 }

  validates :cc_exp_year, presence: true, numericality: { only_integer: true, minimum: Date.today.year }

  validates :status, presence: true, inclusion: { in: %w(pending paid complete cancelled), message: "%{value} is not a valid status" }

  def state_array
    %w(AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY)
  end

  def get_orders
    return find_orders
  end

  private

  def find_orders
    return self.orders
  end

  def find_orders
    return self.orders
  end
end
