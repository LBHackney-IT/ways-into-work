class ClientsController < ApplicationController

  before_action :authenticate_user_login!

  def new
    @client = Client.new()
  end

end
