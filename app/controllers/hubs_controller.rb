class HubsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: geojson }
    end
  end

  private
    def geojson
      { token: WaysIntoWork.config.mapbox_access_token,
        maps: Hub.all.collect do |hub|
        {
          lon: hub.longitude,
          lat: hub.latitude,
          hub_id: hub.id,
          name: hub.name,
          street: hub.address_line_1
        }
      end
      }
    end
end
