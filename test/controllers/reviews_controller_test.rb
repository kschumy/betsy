require "test_helper"

describe ReviewsController do
  let(:products) { products(:ball) }
  let(:merchant) { merchants(:astro) }
  describe "create review" do

    it "won't let a merchant review their own product" do
      perform_login(merchants(:astro), :github)
      get new_product_review_path(products(:ball))
      must_respond_with :redirect

      post product_reviews_path(products(:ball)), params: { rating: 1}
      must_respond_with :redirect
    end


    it "will let merchants review other's products" do
      perform_login(merchants(:astro), :github)
      get new_product_review_path(products(:soap))
      must_respond_with :success

      proc { post product_reviews_path(products(:soap)), params: {rating: 3}}.must_change 'Review.count', 1
      must_respond_with :redirect
    end
  end

  describe "new review" do
    it "should be able to create a review" do
      perform_login(merchants(:astro), :github)
      proc { post product_reviews_path(products(:icecream)), params: {rating: 5}}.must_change 'Review.count', 1
      must_respond_with :redirect
      must_redirect_to product_path(product.id)

    end
  end
end
