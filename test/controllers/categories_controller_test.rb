require "test_helper"

describe CategoriesController do
  let (:novelty) { categories(:novelty) }
  let(:astro) { merchants(:astro) }


  it "should get index" do
    get categories_path
    value(response).must_be :success?
  end

  it "should get show" do
    get category_path(:id)
    value(response).must_be :success?
  end

  it "should not let a guest get new" do
    get new_category_path
    must_respond_with :not_found
  end

  it "should let a merchant get new" do
    @merchant = merchants(:astro)
    login(@merchant, :github)
    get new_category_path
    must_respond_with :success
  end

  it "should let a merchant create a new category" do
    login(merchants, :github)
    proc { post categories_path, params: {category: {name: "Marscrafts"}}}.must_change 'Category.count', 1
    must_respond_with :redirect
  end

  it "should not let a guest create a new category" do
    proc { post categories_path, params: {category: {name: "Marscrafts"}}}.must_change 'Category.count', 0
    must_respond_with :not_found
  end

  it "must be a unique category" do
    login(merchants(:astro), :github)
    astro.name.must_equal "crafts"
    proc { post categories_path, params: {category: {name: "crafts"}}}.must_change 'Category.count', 0
  end

end
