require "test_helper"

describe MerchantsController do
  let (:merchant) { merchants(:astro) }


  it "should get index" do
    get merchants_path
    value(response).must_be :success?
  end


  # describe 'show page' do
  #
  #   describe "guest access" do
  #     it "should redirect if trying to access someone else's page" do
  #       get merchant_path(merchant.id)
  #       must_respond_with :redirect
  #     end
  #
  #     it "should render 404 if user show page does not exist" do
  #       get merchant_path(-100)
  #       must_respond_with :not_found
  #     end
  #   end


    #   it "should respond to show" do
    #     get merchants_path
    #     value(response).must_be :success?
    #   end
    # end


    # it "should get show" do
    #   get merchants_show_url
    #   value(response).must_be :success?
    # end
    #
    # it "should get new" do
    #   get merchants_new_url
    #   value(response).must_be :success?
    # end
    #
    # it "should get create" do
    #   get merchants_create_url
    #   value(response).must_be :success?
    # end
    #
    # it "should get edit" do
    #   get merchants_edit_url
    #   value(response).must_be :success?
    # end
    #
    # it "should get update" do
    #   get merchants_update_url
    #   value(response).must_be :success?
    # end
    #
    # it "should get destroy" do
    #   get merchants_destroy_url
    #   value(response).must_be :success?
    # end

  end
end
