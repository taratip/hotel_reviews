class ReviewsController < ApplicationController
  def create
    @hotel = Hotel.find(params[:hotel_id])
    @review = @hotel.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      flash[:notice] = "Thanks for your input!"
    else
      flash[:error] = "Something is wrong with your review."
    end
    redirect_to @hotel
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])

    if @review.update_attributes(review_params)
      redirect_to hotel_path(@review.hotel_id), notice: 'Review was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    hotel_id = @review.hotel_id

    @review.destroy

    redirect_to hotel_path(hotel_id), notice: 'The review was deleted.'
  end
  protected
  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
