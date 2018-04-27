
require "test_helper"

describe Merchant do
  let(:new_merchant) { Merchant.new }
  let(:astro) { merchants(:astro) }

  describe "validations" do

    it "must be valid" do
      astro.must_be :valid?
    end

    it "must have a username" do
      astro.username = nil
      astro.valid?.must_equal false
      astro.username = "Astro_Anna"
      astro.valid?.must_equal true
    end

    it "username must be unique" do
      astro.username.must_equal "Astro_Anna"
      new_merchant.username = "Astro_Anna1"
      new_merchant.valid?.must_equal false
    end

    it "must have an email address" do
      astro.valid?.must_equal true
      astro.email = nil
      astro.valid?.must_equal false
      astro.save
      astro.errors.keys.must_include :email
    end
  end

  describe "get_merchant_products" do
    it "responds to get_merchant_products" do
      merchant = merchants(:quasar)
      merchant.must_respond_to :get_merchant_products
      merchant.get_merchant_products.must_be_kind_of ActiveRecord::Relation
    end

    it "must return the merchant's products" do
      merchant = merchants(:quasar)
      merchant.get_merchant_products.must_equal merchant.products
    end

    it "must update as new products are added" do
      merchants(:quasar).products.include?(products(:ball)).must_equal false
      product = products(:ball)
      product.update(merchant: merchants(:quasar))

      merchants(:quasar).get_merchant_products.must_include product
      product.merchant.must_equal merchants(:quasar)
    end
  end


end
