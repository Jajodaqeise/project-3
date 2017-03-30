class Api::FindSchoolsController < ApplicationController

  def index
    lat = params[:lat]
    lng = params[:lng]
    location = "#{lat},#{lng}"
    search = params[:search]


    headers ={
      "key" => "AIzaSyClwYiKGAt5Ia23N0EK8trzEZ_L-8oYAgk"
    }

    response = HTTParty.get(
          "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{location}&radius=50&type=school&keyword=#{search}&key=AIzaSyClwYiKGAt5Ia23N0EK8trzEZ_L-8oYAgk").parsed_response

    results = response["results"]

    render :json => response

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


