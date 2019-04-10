class InternalApprenticeship < ApplicationRecord
  include UrlProcessor

  acts_as :opportunity

  validates :pay, presence: true
  validates :contract, presence: true
  validates :sector, presence: true
  validates :url, presence: true

  before_save :smart_add_url_protocol

end
