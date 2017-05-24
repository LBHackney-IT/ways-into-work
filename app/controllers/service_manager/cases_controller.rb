class ServiceManager::CasesController < ApplicationController

  def index
    @clients = Client.all
  end

end
