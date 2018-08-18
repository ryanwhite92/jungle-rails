class ReviewsController < ApplicationController
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

  private
  def review_params
    params.require(:review).permit(:rating, :description)
  end
end
