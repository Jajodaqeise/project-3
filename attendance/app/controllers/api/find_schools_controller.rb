class Api::FindSchoolsController < ApplicationController

  def index
  end

  def create
    lat = params[:lat]
    lng = params[:lng]
    search = params[:search]

<<<<<<< HEAD
    # puts lat
    # puts lng
    # puts search

    response = HTTParty.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{lng}&rankby=distance&type=school&keyword=#{search}&key=AIzaSyBmZUgu0IoJ3_fCRho5cnYkyM09Xyd3738").parsed_response
=======

    response = HTTParty.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{lng}&rankby=distance&type=school&keyword=#{search}&key=AIzaSyClwYiKGAt5Ia23N0EK8trzEZ_L-8oYAgk").parsed_response
>>>>>>> c456739fce1d9c32e3d46516254ce8eb23464fb9

    results = response["results"]

    render :json => results


  end


end
