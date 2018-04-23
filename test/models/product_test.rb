require "test_helper"

describe Product do
  let(:product) { products(:ball) }
  let(:novelty) { categories(:novelty)}
  let(:clothing) { categories(:clothing)}

  describe "relations" do
    it "responds to categories" do
      product.must_respond_to :categories
    end

    it "must have a category field" do
      product.categories.must_equal []
      product.categories << novelty
      category = Category.find_by name: "Novelty"
      product.categories.must_include category
    end

    it "must be added to category's list of products" do
      product.categories << novelty
      novelty.products.must_include(product)
    end

    it "can have multiple categories" do
      product.categories << novelty
      product.categories << clothing
      product.categories.must_equal [categories(:novelty), categories(:clothing)]
      product.categories.count.must_equal 2
    end

  end
end
