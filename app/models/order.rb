class Order < ApplicationRecord
  has_many :order_items

  STATES = %w(
    AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO
    MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY
  )

  STATUS = %w(pending paid complete cancelled)

  validate :validate_all_info, on: :checkout
  # validates :customer_name, presence: true
  # validates :email_address, presence: true
  # # validation of email is not restricted, only requires @
  # validates_format_of :email_address, :with => /@/
  # validates :cc_name, presence: true
  # validates :cc_number, presence: true, length: { is: 16 }
  # validates :cc_cvv, presence: true, length: { is: 3 }
  # validates :cc_zip, presence: true, length: { minimum: 5 }
  # validates :street, presence: true
  # validates :city, presence: true
  # validates :state, presence:true, inclusion: { in: STATES, message: "%{value} is not a valid state"}
  # validates :mailing_zip, presence: true, length: { minimum: 5 }
  # validates :cc_exp_month, presence: true, numericality: { only_integer: true, in: 1..12 }
  # validates :cc_exp_year, presence: true, numericality: { only_integer: true, minimum: Date.today.year }
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

  def add_item_to_cart(new_order_item)
    self.order_items << new_order_item
  end


  private

  def calc_revenue
    order_items = self.order_items
    return order_items.inject(0) { |sum, order_item| sum + order_item.get_item_subtotal }
  end

  def self.validate_all_info
    # validates :customer_name, presence: true
    if !customer_name.is_a?(String) || customer_name.blank?
      errors.add(:customer_name, "Invalid name #{customer_name.inspect}")
    end

    # validates :email_address, presence: true
    # validation of email is not restricted, only requires @
    # validates_format_of :email_address, :with => /@/
    if !email_address.is_a?(String) || !customer_name.include?("@")
      errors.add(:email_address, "Invalid email_address #{email_address.inspect}")
    end

    # !! Same message for all credit card errors for security reasons.
    # validates :cc_name, presence: true
    if !cc_name.is_a?(String) || cc_name.blank?
      errors.add(:credit_card, "Invalid credit card info")
    end

    # TODO: make helper method for all cc number validation
    # validates :cc_number, presence: true, length: { is: 16 }
    if !cc_number.is_a?(String) || cc_number.length != 16 || cc_number.match?(/[^\d]/)
      errors.add(:credit_card, "Invalid credit card info")
    end

    # validates :cc_cvv, presence: true, length: { is: 3 }
    if !cc_cvv.is_a?(String) || cc_cvv.length != 3 || cc_cvv.match?(/[^\d]/)
      errors.add(:credit_card, "Invalid credit card info")
    end

    # validates :cc_zip, presence: true, length: { minimum: 5 }
    if !cc_zip.is_a?(String) || cc_zip.length != 5 || cc_zip.match?(/[^\d]/)
      errors.add(:credit_card, "Invalid credit card info")
    end

    # validates :cc_exp_month, presence: true, numericality: { only_integer: true, in: 1..12 }
    if !cc_exp_month.is_a?(Integer) || !cc_exp_month.between(1..12)
      errors.add(:credit_card, "Invalid credit card info")
    end

    # validates :cc_exp_year, presence: true, numericality: { only_integer: true, minimum: Date.today.year }
    if !cc_exp_year.is_a?(Integer) || !cc_exp_year.between(Date.today.year...9999) ||
      (Date.today.month > cc_exp_month && cc_exp_year == Date.today.year)
      errors.add(:credit_card, "Invalid credit card info")
    end

    # validates :street, presence: true
    if !street.is_a?(String) || street.blank?
      errors.add(:street, "Invalid street #{street.inspect}")
    end

    # validates :city, presence: true
    if !city.is_a?(String) || city.blank?
      errors.add(:city, "Invalid city #{city.inspect}")
    end

    # validates :state, presence:true, inclusion: { in: STATES, message: "%{value} is not a valid state"}
    if !state.is_a?(String) || STATES.include?(state)
      errors.add(:state, "Invalid state #{state.inspect}")
    end

    # validates :mailing_zip, presence: true, length: { minimum: 5 }
    if !mailing_zip.is_a?(String) || mailing_zip.length != 5 || mailing_zip.match?(/[^\d]/)
      errors.add(:mailing_zip, "Invalid mailing zip code #{mailing_zip}")
    end
  end

end
