module Opportunity

  def self.all_active
    opportunities = Job.all + ExternalApprenticeship.all
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