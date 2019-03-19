class ExternalApprenticeship < ApplicationRecord
  include Opportunity

  has_many :enquiries, as: :opportunity

end