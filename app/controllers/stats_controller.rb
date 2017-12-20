class StatsController < ApplicationController
  
  before_action :fetch_filter_params
  
  def index
    date = Date.new(@year.to_i, @month.to_i)
    @registered = Client.registered_on(date).by_hub_id(@hub).count
    OutcomeOption.all.each do |o|
      instance_variable_set("@#{o.id}", Client.with_outcome(o.id, date).by_hub_id(@hub).count)
    end
  end
  
  private
  
  def fetch_filter_params
    @month = params[:month] || Time.zone.today.month
    @year = params[:year] || Time.zone.today.year
    @hub = params[:hub]
  end
  
end
