class RatingController < ApplicationController
  def create
    this_rating = Rating.find_or_create_by(bike_rack_id: params[:ratingData][:rackID].to_i, user_id: current_user.id)
    this_rating.update_attributes(rating: params[:ratingData][:newRating].to_i)

    render json: update_average
  end

  private
  def update_average
    sum = 0
    collection = Rating.where(bike_rack_id: params[:ratingData][:rackID].to_i)
    collection.each do |rating|
      sum += rating.rating
    end
    BikeRack.find(params[:ratingData][:rackID].to_i).update_attributes(rating: sum/collection.count)
    return collection.count
  end
end
