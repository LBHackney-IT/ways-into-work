class HubsController < ApplicationController
  before_action :fetch_hubs
  
  def index
    respond_to do |format|
      format.html
      format.json { render json: geojson }
    end
  end

  private

  def geojson
    {
      token: WaysIntoWork.config.mapbox_access_token,
      maps: @hubs.collect { |hub| HubSerializer.new(hub) }
    }
  end
  
  def fetch_hubs
    @hubs = Hub.all
  end
  
end
