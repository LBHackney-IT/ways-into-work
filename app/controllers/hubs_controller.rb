class HubsController < ApplicationController
  expose :hubs, -> { Hub.order(name: :asc) }

  def index; end
    
end
