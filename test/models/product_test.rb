require "test_helper"

describe Product do
  let(:product) { products(:ball) }
  let(:novelty) { categories(:novelty)}

  describe "relations" do
    it "must have a category field" do
      product.categories.must_equal []
      product.categories << novelty
      category = Category.find_by name: "Novelty"
      product.categories.must_include category
    end

    #
    #   it "has a list of voting users" do
    #     album = works(:album)
    #     album.must_respond_to :ranking_users
    #     album.ranking_users.each do |user|
    #       user.must_be_kind_of User
    #     end
    #   end
    # end
    #
    #
    # it "must be valid" do
    #   value(product).must_be :valid?
    # end
  
end
