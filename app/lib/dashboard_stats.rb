class DashboardStats
  def initialize(from, to, options = {})
    @options = options
    @from = from
    @to = to
    @base_query = Client.by_hub_id(@options[:hub])
                        .by_advisor_id(@options[:advisor])
                        .by_funding_code(@options[:funding_code])
    apply_equalities if @options[:equalities]
  end

  def apply_equalities
    option = EqualitiesOption.find(@options[:equalities])
    @base_query = @base_query.send(option.id.to_sym) if option
  end

  def self.stats_for_year(date, options = {})
    (1..12).map do |month|
      date = date.change(month: month)
      new(date.beginning_of_month, date.end_of_month, options)
    end
  end

  def registered
    @base_query.registered_on(@from, @to).count
  end

  def initial_assessments
    @base_query.initial_assessments_attended(@from, @to).count
  end

  def with_outcome(id)
    @base_query.with_outcome(id, @from, @to).count
  end

  def csv_header
    ['From date', 'To date', 'Registered'] +
      AchievementOption.all.map { |outcome| I18n.t("stats.titles.#{outcome.id}") }
  end

  def csv_row
    [@from.strftime('%Y-%m-%d'), @to.strftime('%Y-%m-%d'), registered, AchievementOption.all.map { |outcome| with_outcome(outcome.id) }].flatten
  end

  def csv
    CSV.generate do |csv|
      csv << csv_header
      DashboardStats.stats_for_year(@from, @options).each do |month|
        csv << month.csv_row
      end
    end
  end
end
