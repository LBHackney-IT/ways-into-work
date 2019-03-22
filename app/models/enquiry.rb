class Enquiry < ApplicationRecord
  belongs_to :client
  belongs_to :opportunity

  enum status: %i[awaiting accepted declined]
end