class HubsController < ApplicationController
  expose :hubs, -> { Hub.where.not(id: [5,6]).order(name: :asc) } # Exclude 'ghost hubs' - Jobs & Employment pathways

  def index; end
    
end
