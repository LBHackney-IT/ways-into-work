class Advisor::DashboardController < Advisor::BaseController
  
  before_action :fetch_filter_params, :initialize_options
  
  def index
    date = Date.new(@year.to_i, @month.to_i)
    base_query = Client.by_hub_id(@hub).by_advisor_id(@advisor)
    @registered = base_query.registered_on(date).count
    OutcomeOption.all.each do |o|
      instance_variable_set("@#{o.id}", base_query.with_outcome(o.id, date).count)
    end
  end
  
  private
  
  def fetch_filter_params
    @month = params[:month] || Time.zone.today.month
    @year = params[:year] || Time.zone.today.year
    @hub = params[:hub]
    @advisor = params[:advisor]
  end
  
  def initialize_options
    @hubs = Hub.options_for_select
    @advisors = Advisor.options_for_select(@hub)
    @months = (1..12).map { |m| [Date.new(2016, m).strftime('%B'), m] }
    @years = (Date.new(2016).year..Time.zone.now.year).to_a
  end
  
end
