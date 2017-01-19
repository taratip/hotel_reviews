require 'pry'
class HotelsController < ApplicationController
  def index
    @hotels = Hotel.all
  end

  def show
    @hotel = Hotel.find(params[:id])
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
    @hotel = Hotel.find(params[:id])
  end

  def update
    @hotel = Hotel.find(params[:id])
    @hotel.user = current_user

    if @hotel.update_attributes(hotel_params)
      redirect_to hotels_path, notice: 'Hotel was successfully updated.'
    else
      render :edit
    end
  end

  private
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
