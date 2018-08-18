class ReviewsController < ApplicationController
  before_action :require_login

  def create
    @product = Product.find(params[:product_id])
    @reviews = Review.where(product_id: params[:product_id]).order(created_at: :desc)
    @review = @product.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to product_path(@product)
    else
      render 'products/show'
    end
  end

  def destroy
    product = Product.find(params[:product_id])
    @review = product.reviews.find(params[:id])
    @review.destroy

    redirect_to product_path(product)
  end

  private
  def review_params
    params.require(:review).permit(:rating, :description)
  end

  def require_login
    unless current_user
      redirect_to product_path(params[:product_id])
      flash[:error] = 'You must be logged in to rate this product'
    end
  end
end
