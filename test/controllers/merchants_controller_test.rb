require "test_helper"

describe MerchantsController do
  describe 'index' do
    it "should get index" do
      get merchants_path
      value(response).must_be :success?
    end
  end

  describe 'show' do
    it "should respond to show" do
      get merchants_path
      value(response).must_be :success?
    end
  end


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
