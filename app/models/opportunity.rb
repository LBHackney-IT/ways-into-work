module Opportunity

  def self.active_ending_first
    opportunities = Job.active + ExternalApprenticeship.active
    opportunities.sort_by { |opportunity| opportunity.end_date }
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
      'External Apprenticeship'
    end
  end
end