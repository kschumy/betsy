require "test_helper"

describe OrdersController do
  let(:order) {post order_products_path(products(:three), order_product: {quantity: 1})}

  it "should get index" do
    get orders_path
    value(response).must_be :success?
  end

  it "should get show" do
    get order_path((:order).id)
    must_respond_with :success
  end

  it "should get new" do
    get orders_new_url
    value(response).must_be :success?
  end

  it "should get create" do
    get orders_create_url
    value(response).must_be :success?
  end

  it "should get edit" do
    get orders_edit_url
    value(response).must_be :success?
  end

  it "should get update" do
    get orders_update_url
    value(response).must_be :success?
  end

  it "should get destroy" do
    get orders_destroy_url
    value(response).must_be :success?
  end

end
