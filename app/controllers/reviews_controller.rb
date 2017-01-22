class ReviewsController < ApplicationController
  before_action :authorize_user, except: [:index, :show]

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

    if @review.user == current_user
      if @review.update_attributes(review_params)
        redirect_to hotel_path(@review.hotel_id), notice: 'Review was successfully updated.'
      else
        render :edit
      end
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

  def destroy
    @review = Review.find(params[:id])
    hotel_id = @review.hotel_id

    @review.destroy

    redirect_to hotel_path(hotel_id), notice: 'The review was deleted.'
  end

  def upvote
    @review = Review.find(params[:id])
    vote = Vote.find_by_user_id_and_review_id(current_user.id, params[:id])

    if vote.nil?
      new_vote = @review.votes.new
      new_vote.user = current_user
      new_vote.vote_type = 'up'
      new_vote.save

      @review.update_attribute(:score, @review.score + 1)
      redirect_to hotel_path(@review.hotel_id), notice: 'Thank you for your vote!'
    else
      if vote.vote_type == 'down'
        vote.update_attribute(:vote_type, 'up')
        @review.update_attribute(:score, @review.score + 1)
        redirect_to hotel_path(@review.hotel_id), notice: 'Thank you for your vote!'
      else
        redirect_to hotel_path(@review.hotel_id), error: 'There was a problem with your vote.'
      end
    end
  end

  def downvote
    @review = Review.find(params[:id])
    vote = Vote.find_by_user_id_and_review_id(current_user.id, params[:id])

    if vote.nil?
      new_vote = @review.votes.new
      new_vote.user = current_user
      new_vote.vote_type = 'down'
      new_vote.save

      @review.update_attribute(:score, @review.score - 1)
      redirect_to hotel_path(@review.hotel_id), notice: 'Thank you for your vote!'
    else
      if vote.vote_type == 'up'
        vote.update_attribute(:vote_type, 'down')
        @review.update_attribute(:score, @review.score - 1)
        redirect_to hotel_path(@review.hotel_id), notice: 'Thank you for your vote!'
      else
        redirect_to hotel_path(@review.hotel_id), notice: 'There was a problem with your vote.'
      end
    end
  end

  def deletevote
    @review = Review.find(params[:id])
    vote = Vote.find_by_user_id_and_review_id(current_user.id, params[:id])

    if !vote.nil?
      if vote.vote_type == 'up'
        @review.update_attribute(:score, @review.score - 1)
      else
        @review.update_attribute(:score, @review.score + 1)
      end

      vote.destroy
      redirect_to hotel_path(@review.hotel_id), notice: 'Your vote was deleted.'
    else
      redirect_to hotel_path(@review.hotel_id), notice: 'There was a problem with your vote.'
    end
  end

  private
  def review_params
    params.require(:review).permit(:rating, :body)
  end

  def authorize_user
    if !user_signed_in?
      raise ActionController::RoutingError.new("Not Found")
    end
  end
end
