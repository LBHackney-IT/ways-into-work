module Opportunity

  def self.active_ending_first
    opportunities = Job.active + ExternalApprenticeship.active
    opportunities.sort_by { |opportunity| opportunity.end_date }
  end

  def self.inactive_ending_first
    old_opportunities = Job.inactive + ExternalApprenticeship.inactive
    old_opportunities.sort_by { |opportunity| opportunity.end_date }
  end

  def self.types
    types = [
      ['Job', Job],
      ['External Apprenticeship', ExternalApprenticeship]
    ]
  end

  def type_string
    case self
    when Job
      'Job'
    when ExternalApprenticeship
      'Apprenticeship'
    end
  end
end
