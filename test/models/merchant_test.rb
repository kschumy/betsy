
require "test_helper"

describe Merchant do
  let(:merchant) { Merchant.new }
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
      merchant.username = "Astro_Anna1"
      merchant.valid?.must_equal false
    end

    it "must have an email address" do
      astro.valid?.must_equal true
      astro.email = nil
      astro.valid?.must_equal false
      astro.save
      astro.errors.keys.must_include :email
    end



  end


end
