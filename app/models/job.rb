class Job < ApplicationRecord
  include Opportunity

  has_many :enquiries, as: :opportunity

end