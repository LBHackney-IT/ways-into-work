class DashboardStats
  
  def initialize(from, to, options = {})
    @base_query = Client.by_hub_id(options[:hub])
                        .by_advisor_id(options[:advisor])
                        .by_funding_code(options[:funding_code])
    @from = from
    @to = to
  end
  
  def registered
    @base_query.registered_on(@from, @to).count
  end
  
  def with_outcome(id)
    @base_query.with_outcome(id, @from, @to).count
  end
  
end
