class Advisor::DashboardController < Advisor::BaseController
  
  before_action :fetch_filter_params, :initialize_options
  
  def index
    @stats = DashboardStats.new(@from, @to, @options)
  end
  
  private
  
  def fetch_filter_params
    fetch_dates
    @options = {}
    @options[:hub] = params[:hub]
    @options[:advisor] = params[:advisor]
    @options[:funding_code] = params[:funding_code]
  end
  
  def fetch_dates
    @month = params[:month] || Time.zone.today.month
    @year = params[:year] || Time.zone.today.year
    setup_date_range
  end
  
  def initialize_options
    @hubs = Hub.options_for_select
    @advisors = Advisor.options_for_select(@hub)
    @funding_codes = FundedOption.all.map { |f| [f.name, f.id] }
    @months = month_options
    @years = (Date.new(2016).year..Time.zone.now.year).to_a
  end
  
  def month_options
    [
      [
        'Month',
        (1..12).map { |m| [Date.new(2016, m).strftime('%B'), m] }
      ],
      [
        'Quarter',
        %w[Q1 Q2 Q3 Q4]
      ]
    ]
  end
  
  def setup_date_range
    if @month.to_s.match?(/Q/)
      setup_quarter
    else
      date = Date.new(@year.to_i, @month.to_i)
      @from = date.beginning_of_month
      @to = date.end_of_month
    end
  end
  
  def setup_quarter
    quarter = @month[1].to_i
    date = Date.new(@year.to_i, quarter * 3)
    @from = date.beginning_of_quarter
    @to = date.end_of_quarter
  end
  
end
