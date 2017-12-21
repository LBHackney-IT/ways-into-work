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
  
  def csv_header
    ['From date', 'To date', 'Registered', OutcomeOption.all.map { |outcome| I18n.t("stats.titles.#{outcome.id}") }].flatten
  end
  
  def csv_row
    [@from.strftime('%Y-%m-%d'), @to.strftime('%Y-%m-%d'), registered, OutcomeOption.all.map { |outcome| with_outcome(outcome.id) }].flatten
  end
  
  def csv
    CSV.generate do |csv|
      csv << csv_header
      csv << csv_row
    end
  end
  
end
