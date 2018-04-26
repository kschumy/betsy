class Order < ApplicationRecord
  has_many :order_items

  STATES = %w(
    AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO
    MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY
  )

  STATUS = %w(pending paid complete cancelled)

  validates :status, presence: true, inclusion: { in: STATUS }

  # validate :valid_customer_name_or_error, unless: "is_pending? && customer_name.nil?"
  # validate :valid_street_or_error, unless: "is_pending? && street.nil?"

  validates_each :customer_name, :street, :city do |record, attrib, value|
    # value.squish! if value.is_a?(String) #
    if !(record.is_pending? && value.nil?) && !is_non_empty_string?(value)
      record.errors[attrib] << "Invalid #{attrib}"
    end
  end
  # validate :street, unless: "is_pending? && street.nil?"
  # validate :street, unless: "is_pending? && street.nil?"
  # validate :street, unless: "is_pending? && street.nil?"
  # validate :street, unless: "is_pending? && street.nil?"

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
  #
  # def is_pending_and_value_nil?(value)
  #   reutis_pending? && value.nil?
  # end

  def destroy_all_order_items
    order_items.each { |items| items.destroy }
  end

  def calc_revenue
    return order_items.inject(0) { |sum, item| sum + item.get_subtotal }
  end

  def validate_mailing_info
    errors.add(:customer_name, "Invalid name") if !is_non_empty_string?(customer_name)
    errors.add(:street, "Invalid street") if !is_non_empty_string?(street)
    errors.add(:city, "Invalid city") if !is_non_empty_string?(city)
    errors.add(:state, "Invalid state") if !STATES.include?(state)
    errors.add(:mailing_zip, "Invalid mailing zip") if !is_zip_code?(mailing_zip)
  end

  def validate_email_address
    if !email_address.is_a?(String) || !email_address.include?("@")
      errors.add(:email_address, "Invalid email address")
    end
  end

  def validate_credit_card_info
    if !is_non_empty_string?(cc_name) || !has_valid_cc_number? ||
      !has_valid_cvv_number? || !is_zip_code?(cc_zip) ||
      !Date.is_in_the_future?(cc_exp_month, cc_exp_year)
      errors.add(:credit_card, "Invalid credit card info")
    end
  end

  def has_valid_cvv_number?
    return is_string_of_n_numbers?(cc_cvv, 3)
  end

  def has_valid_cc_number?
    return cc_number.is_a?(Integer) &&
      cc_number.between?(1_000_000_000_000_000, 9_999_999_999_999_999)
  end

  def is_zip_code?(zip)
    return is_string_of_n_numbers?(zip, 5)
  end

  # def is_string_of_n_numbers?(input, n)
  #   return input.is_a?(String) && input.length == n && !input.match?(/[^\d]/)
  # end

  def valid_street_or_error
    if !is_non_empty_string?(street)
      errors.add(:street, "Invalid street name")
    end
  end

  # # def valid
  # def valid_string(attrib, value)
  #   if !is_non_empty_string?(value)
  #     errors.add(attrib, "Invalid customer name")
  #   end
  # end

  def valid_customer_name_or_error
    if !is_non_empty_string?(customer_name)
      errors.add(:customer_name, "Invalid customer name")
    end
  end

  # def self.is_non_empty_string?(input)
  #   return input.is_a?(String) && !input.blank? && input[0].match?(/\S/)#blank?
  # end

end





# class String
#   def has_only_n_digits?(n)
#     return length == n && !self.match?(/[\D]/)
#   end
#
# end

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
