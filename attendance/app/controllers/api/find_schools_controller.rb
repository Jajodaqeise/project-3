class Api::FindSchoolsController < ApplicationController

  def index
  end

  def create
    lat = params[:lat]
    lng = params[:lng]
    search = params[:search]

    # puts lat
    # puts lng
    # puts search

    response = HTTParty.get(
          "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{lng}&rankby=distance&type=school&keyword=#{search}&key=AIzaSyClwYiKGAt5Ia23N0EK8trzEZ_L-8oYAgk").parsed_response

    results = response["results"]

    respond_to do |format|
      format.json
      format.js {render json: results, content_type: 'text/json'}
    end

    # geometries = []
    # results.each do |result|
    #   geometries << result["geometry"]
    # end

    # locations = []
    # geometries.each do |geometry|
    #    locations << geometry["location"]
    # end

    # puts locations

  end


end


