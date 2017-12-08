class HubsController < ApplicationController
  expose :hubs, -> { Hub.order(name: :desc) }

  def index; end
    
end
