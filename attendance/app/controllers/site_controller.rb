class SiteController < ApplicationController
  def index
    @no_nav = true
    # render :layout => false
  end
end
