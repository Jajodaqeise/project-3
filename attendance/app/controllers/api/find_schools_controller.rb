class Api::FindSchoolsController < ApplicationController

  def index
  end

  def create
    lat = params[:lat]
    lng = params[:lng]
    search = params[:search]

    response = HTTParty.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{lng}&rankby=distance&type=school&keyword=#{search}&key=AIzaSyBmZUgu0IoJ3_fCRho5cnYkyM09Xyd3738").parsed_response

    results = response["results"]

    render :json => results
  end


end
