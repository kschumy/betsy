class Order < ApplicationRecord
  has_many :order_items

  STATES = %w(
    AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO
    MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY
  )

  STATUS = %w(pending paid complete cancelled)


  validates :customer_name, presence: true
  validates :email_address, presence: true
  # validation of email is not restricted, only requires @
  validates_format_of :email_address, :with => /@/
  validates :cc_name, presence: true
  validates :cc_number, presence: true, length: { is: 16 }
  validates :cc_cvv, presence: true, length: { is: 3 }
  validates :cc_zip, presence: true, length: { minimum: 5 }
  validates :street, presence: true
  validates :customer_name, presence: true
  validates :city, presence: true
  validates :state, presence:true, inclusion: { in: STATES, message: "%{value} is not a valid state"}
  validates :mailing_zip, presence: true, length: { minimum: 5 }

  validates :cc_exp_month, presence: true, numericality: { only_integer: true, in: 1..12 }

  validates :cc_exp_year, presence: true, numericality: { only_integer: true, minimum: Date.today.year }

  validates :status, presence: true, inclusion: { in: STATUS, message: "%{value} is not a valid status" }

  def self.show_pending
    show_orders("pending")
  end

  def self.show_paid
    show_orders("paid")
  end

  def self.show_complete
    show_orders("complete")
  end

  def self.show_cancelled
    show_orders("cancelled")
  end

  def get_total_revenue
    return calc_revenue
  end


  private

  def calc_revenue
    order_items = self.order_items
    return order_items.inject(0) { |sum, order_item| sum + order_item.get_item_subtotal }
  end

end
