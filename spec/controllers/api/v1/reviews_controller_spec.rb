require "rails_helper"
require 'pry'

RSpec.describe Api::V1::ReviewsController, type: :controller do
  describe "POST /api/v1/reviews/:id/upvote" do
    it "up vote a review" do
      user = FactoryGirl.create(:user)
      review = FactoryGirl.create(:review)
      sign_in user

      post :upvote, params: { id: review.id }

      expect(response).to have_http_status(:created)
    end

    it "returns 'not_found' if attempts to vote twice" do
      user = FactoryGirl.create(:user)
      review = FactoryGirl.create(:review)
      sign_in user

      post :upvote, params: { id: review.id }
      post :upvote, params: { id: review.id }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/v1/reviews/:id/upvote" do
    it "down vote a review" do
      user = FactoryGirl.create(:user)
      review = FactoryGirl.create(:review)
      sign_in user

      post :downvote, params: { id: review.id }

      expect(response).to have_http_status(:created)
    end

    it "returns 'not_found' if attempts to vote twice" do
      user = FactoryGirl.create(:user)
      review = FactoryGirl.create(:review)
      sign_in user

      post :downvote, params: { id: review.id }
      post :downvote, params: { id: review.id }

      expect(response).to have_http_status(:not_found)
    end

    it "raise error when unauthenticated user attempts to vote a review" do
      review = FactoryGirl.create(:review)

      expect{ post :upvote, params: { id: review.id } }.to raise_error(ActionController::RoutingError)
    end
  end

  describe 'POST /api/v1/reviews/:id/deletevote' do
    it "delete a vote" do
      user = FactoryGirl.create(:user)
      review = FactoryGirl.create(:review)
      sign_in user

      post :downvote, params: { id: review.id }
      post :deletevote, params: { id: review.id }

      json = JSON.parse(response.body)
      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(:created)
      expect(json["vote_type"]).to eq("down")
    end

    it "returns 'not_found' if attempts to delete non-existing vote" do
      user = FactoryGirl.create(:user)
      review = FactoryGirl.create(:review)
      sign_in user

      post :deletevote, params: { id: review.id }

      expect(response).to have_http_status(:not_found)
    end
  end
end
