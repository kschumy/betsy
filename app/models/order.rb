class Order < ApplicationRecord
  has_many :order_items

  STATES = %w(
    AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO
    MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY
  )

  STATUS = %w(pending paid complete cancelled)

  # to do
  #   order_items: []

  # done
  #   cc_name: "Test Dummy",
  #   customer_name: "Ada MarsFan",
  #   street: "123 Space Ave",
  #   city: "Seattle",
  #   status: "pending",
  #   cc_zip: "99503",
  #   mailing_zip: "98103",
  #   email_address: "starmouse@crater.com",
  #   cc_number: 1234192910312811,
  #   cc_cvv: "201",
  #   state: "WA",
  #   cc_exp_month: 12,
  #   cc_exp_year: 2050,

  validates :status, presence: true, inclusion: { in: STATUS }

  validates :state, presence: true,
                inclusion: { in: STATES },
                if: -> { !(is_pending? && state.nil?) }

  validate :validate_email_address,
              if: -> { !(is_pending? && email_address.nil?) }

  validate :validate_credit_card_expiration,
              if: -> { !(is_pending? && cc_exp_month.nil? && cc_exp_year.nil?) }

  validate :validate_cc_number,
              if: -> { !(is_pending? && cc_number.nil?) }

  validate :validate_cc_cvv,
              if: -> { !(is_pending? && cc_cvv.nil?) }


  validates_each :customer_name, :street, :city, :cc_name do |record, attrib, value|
    if !(record.is_pending? && value.nil?) && !is_non_empty_string?(value)
      record.errors[attrib] << "Invalid #{attrib} - cannot be empty"
    end
  end

  validates_each :mailing_zip, :cc_zip do |record, attribute, value|
    if !(record.is_pending? && value.nil?) && !is_zip_code?(value)
      record.errors[attribute] << "Invalid #{attribute} - must be 5 digits"
    end
  end

  def get_current_total
    return calc_revenue if is_pending?
  end

  # def get_total_revenue(merchant)
  #   return calc_revenue if !is_pending?
  # end

  def add_item_to_cart(new_order_item)
    order_items << new_order_item if is_pending?
  end

  def is_pending?
    return status == "pending"
  end

  def is_not_allowed_to_change?
    return status != "pending"
  end

  def delete_all_items_in_cart
    destroy_all_order_items if is_pending?
  end

  private

  def destroy_all_order_items
    order_items.each { |items| items.destroy }
  end

  def calc_revenue
    return order_items.inject(0) { |sum, item| sum + item.get_subtotal }
  end

  def validate_email_address
    if !email_address.is_a?(String) || !email_address.include?("@")
      errors.add(:email_address, "Invalid email address")
    end
  end

  def validate_credit_card_expiration
    if !Date.is_in_the_future?(cc_exp_month, cc_exp_year)
      errors.add(:credit_card_expiration, "Invalid credit card expiration date")
    end
  end

  def validate_cc_cvv
    if !cc_cvv.is_a?(String) || !cc_cvv.has_only_n_digits?(3)
      errors.add(:credit_card_cvv, "Invalid credit card cvv")
    end
  end

  def validate_cc_number
    if !cc_number.is_a?(Integer) ||
      !cc_number.between?(1_000_000_000_000_000, 9_999_999_999_999_999)
        errors.add(:credit_card_number, "Invalid credit card number")
    end
  end

  def self.is_zip_code?(zip)
    return zip.is_a?(String) && zip.has_only_n_digits?(5)
  end

end

class String
  def has_only_n_digits?(n)
    raise ArgumentError.new("'n' must be int > 0") if !n.is_a?(Integer) && n < 0
    return length == n && !self.match?(/[\D]/)
  end

end

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

# def self.show_pending
#   show_orders("pending")
# end
#
# def self.show_paid
#   show_orders("paid")
# end
#
# def self.show_complete
#   show_orders("complete")
# end
#
# def self.show_cancelled
#   show_orders("cancelled")
# end


  #
  # validates_presence_of :customer_name, if: -> {  !is_pending? || customer_name.nil? }


  # validates_with MyValidator unless: "is_pending? || customer_name.nil?"

  # validates_with GoodnessValidator, fields: [:first_name, :last_name]

 #  validates_each :name, :surname do |record, attr, value|
 #   record.errors.add(attr, 'must start with upper case') if value =~ /\A[[:lower:]]/
 # end

  # validates :customer_name, presence: true,
  #                   if: [Proc.new { |c| c.market.retail? }, :desktop?],
  #                   unless: Proc.new { |c| c.trackpad.present? }


  # validate do
  #   errors.add(:customer_name, 'Invalid name') unless
  # end

  # validates :customer_name, if: Proc.new { is_non_empty_string?(customer_name) }, unless: "is_pending? && customer_name.nil?"
      # if: Proc.new { |u_name| u_name.username.nil? || !is_pending? },
      # unless: "is_pending? || customer_name.nil?"

  # validates :username, length: { minimum: 8 }, if: :has_username?

#  def has_username?
#    !(username.nil? || username.empty?)
#  end
#
#
#
#   validates :username, length: { minimum: 8 },
#                 unless: "username.nil? || username.empty?"
# end
#
#   validates :username, length: { minimum: 8 },
#                 unless: Proc.new { |u| u.username.nil? || u.username.empty? }
# end

  # validate :validate_mailing_info, on: :checkout
  # validate :validate_credit_card_info, on: :checkout
  # validate :validate_email_address, on: :checkout

  # validate :validate_mailing_info, if: :is_not_allowed_to_change?
  # validate :validate_credit_card_info, if: :is_not_allowed_to_change?
  # validate :validate_email_address, if: :is_not_allowed_to_change?

  # with_options if: :is_not_allowed_to_change? do
  #   validate :validate_mailing_info
  #   validate :validate_credit_card_info
  #   validate :validate_email_address
  # end


  #
  # class MyValidator < ActiveModel::Validator
  #   def validate(record)
  #     if record.is_a?(String) && !record.blank?
  #       record.errors.add :base, 'This record is invalid'
  #     end
  #   end
  #
  #   private
  #   def some_complex_logic
  #     # ...
  #   end
  # end

  # include ActiveModel::Validations

  # validate :valid_customer_name_or_error, unless: "is_pending? && customer_name.nil?"
  # validate :valid_street_or_error, unless: "is_pending? && street.nil?"
