class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by(id: params[:id])
  end

  def new
    if @merchant.nil?
      render_404
    else
      @category = Category.new
    end
  end

  def create
    if @merchant.nil?
      flash[:status] = :failure
      flash[:result_text]= "You must be logged in to add a new category"
      redirect_to root_path
    else
      @category = Category.new(category_params)
      if @category.save
        flash[:status] = :success
        flash[:result_text] = "Succesfully created category: #{@category.name}!"
        redirect_to merchant_path(@merchant.id)
      else
        flash[:status] = :failure
        flash[:notice] = "Blah! Blah!"
        flash[:messages] = @category.errors.messages
        render :new, status: :bad_request
      end
    end
  end

  private

  def category_params
    return params.require(:category).permit(:name)
  end

end
