require 'pry'
class Api::V1::ReviewsController < Api::V1::ApiController
  before_action :authorize_user

  def index
    reviews = Review.order(created_at: :desc).limit(10)

    render json: reviews
  end

  def upvote
    review = Review.find(params[:id])
    vote = Vote.find_by_user_id_and_review_id(current_user.id, params[:id])

    if vote.nil?
      new_vote = review.votes.new
      new_vote.user = current_user
      new_vote.vote_type = 'up'
      new_vote.save

      review.update_attribute(:score, review.score + 1)
      render json: :nothing, status: :created
    else
      if vote.vote_type == 'down'
        vote.update_attribute(:vote_type, 'up')
        review.update_attribute(:score, review.score + 1)
        render json: :nothing, status: :created
      else
        render json: :nothing, status: :not_found
      end
    end
  end

  def downvote
    review = Review.find(params[:id])
    vote = Vote.find_by_user_id_and_review_id(current_user.id, params[:id])

    if vote.nil?
      new_vote = review.votes.new
      new_vote.user = current_user
      new_vote.vote_type = 'down'
      new_vote.save

      review.update_attribute(:score, review.score - 1)
      render json: :nothing, status: :created
    else
      if vote.vote_type == 'up'
        vote.update_attribute(:vote_type, 'down')
        review.update_attribute(:score, review.score - 1)
        render json: :nothing, status: :created
      else
        render json: :nothing, status: :not_found
      end
    end
  end

  def deletevote
    review = Review.find(params[:id])
    vote = Vote.find_by_user_id_and_review_id(current_user.id, params[:id])
    vote_type = ''

    if !vote.nil?
      if vote.vote_type == 'up'
        vote_type = 'up'
        review.update_attribute(:score, review.score - 1)
      else
        vote_type = 'down'
        review.update_attribute(:score, review.score + 1)
      end

      vote.destroy
      render json: { vote_type: vote_type }, status: :created
    else
      render json: :nothing, status: :not_found
    end
  end

  private
  def authorize_user
    if !user_signed_in?
      raise ActionController::RoutingError.new("Not Found")
    end
  end
end
