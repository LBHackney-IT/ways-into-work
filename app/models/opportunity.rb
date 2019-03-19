module Opportunity

  def self.all_active
    Job.all
  end

  def self.types
    types = [
      ['Job', Job],
      ['External Apprenticeship', ExternalApprenticeship]
    ]
  end
end