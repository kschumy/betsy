class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by(id: params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    Category.create(category_params)
    redirect_to categories_path
  end

  def edit
    @category = Category.find_by(id:params[:id])
    if @category.nil?
      redirect_to categories_path
    end
  end

  def update
  end

  def destroy
  end

  private
  def category_params
    return
    params.require(:category).permit(:name, :id)
  end
end
