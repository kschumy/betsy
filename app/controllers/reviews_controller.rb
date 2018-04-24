class ReviewsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @product = Product.find_by(id:params[:product_id])
    if find_merchant && @merchant.id == @product.merchant.id
      flash[:status] = :failure
      flash[:notice] = "You can't review your own product!"
      redirect_to product_path(@product.id)
    else
      render_404 unless @product
      @review = Review.new
    end
  end

  def create
    @product = Product.find_by(id:params[:product_id])
    if find_merchant && @merchant.id == @product.merchant.id
      flash.now[:failure] = "You can't review your own product!"
      redirect_to product_path(@product.id)
    else
      @review = Review.new(review_params)
      if @review.save
        flash[:success] = :success
        flash[:result_text] = "Your review was added succesfully!"
        redirect_to product_path(@review.product_id)
      else
        flash[:failure] = :failure
        flash[:notice] = "A problem occured with your review!"
        flash[:messages] = @review.errors.messages
        @product = Product.find_by(id: params[:product_id])
        render :new, status: :bad_request
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def review_params
    params.permit(:rating, :comment, :product_id)
  end
end
