require 'pry'
class HotelsController < ApplicationController
  before_action :set_hotel, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, except: [:index, :show, :search]

  def index
    @hotels = Hotel.all
  end

  def show
    @review = @hotel.reviews.build
  end

  def new
    @hotel = Hotel.new
  end

  def create
    @hotel = Hotel.new(hotel_params)
    @hotel.user = current_user

    if @hotel.save
      redirect_to hotel_path(@hotel), notice: 'Hotel was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @hotel.user == current_user
      if @hotel.update_attributes(hotel_params)
        redirect_to hotels_path, notice: 'Hotel was successfully updated.'
      else
        render :edit
      end
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

  def destroy
    if @hotel.user == current_user or current_user.admin?
      @hotel.destroy

      redirect_to hotels_path, notice: 'The hotel was deleted.'
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

  def search
    query = "%#{params[:query].downcase}%"
    @hotels = Hotel
              .where('lower(name) like ? or lower(address) like ? or lower(description) like ?',
              query, query, query)
  end

  private
  def set_hotel
    @hotel = Hotel.find(params[:id])
  end

  def hotel_params
    params.require(:hotel).permit(
      :name,
      :address,
      :description,
      :number_rooms,
      :image
    )
  end
end
