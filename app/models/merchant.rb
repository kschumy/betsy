class Merchant < ApplicationRecord
  has_many :products

  def self.build_from_github(auth_hash)
    return Merchant.new(
      provider: auth_hash[:provider],
      uid: auth_hash[:uid],
      email: auth_hash[:info][:email],
      name: auth_hash[:info][:name]
    )

  end
end
