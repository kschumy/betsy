class Merchant < ApplicationRecord
  has_many :products

  # PRE: provided auth_hash must be a hash and have the key :info. Otherwise,
  # throws ArgumentError.
  # Returns a new instance of Merchant from provided auth_hash.
  def self.build_from_github(auth_hash)
    valid_auth_hash_or_error(auth_hash)
    create_new_merchant(auth_hash)
  end

  private

    # Throw ArgumentError if provided auth_hash is not a hash or if it does not
    # have the key :info.
    def self.valid_auth_hash_or_error(auth_hash)
      # if !auth_hash.is_a?(OmniAuth::AuthHash) || !auth_hash.has(:info)
        raise ArgumentError.new("Invalid initial format from provider")
      # end
    end

    # PRE: provided auth_hash must be a hash and have the key :info.
    # Returns a new instance of Merchant, using the provided auth_hash to supply
    # provider, uid, email, and username.
    def self.create_new_merchant(auth_hash)
      return Merchant.new(
        provider: auth_hash[:provider],
        uid: auth_hash[:uid],
        email: auth_hash[:info][:email],
        username: auth_hash[:info][:name]
      )
    end

end
