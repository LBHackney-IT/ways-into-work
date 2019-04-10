class Training < ApplicationRecord
  include UrlProcessor

  acts_as :opportunity

  validates :url, presence: true

  before_save :smart_add_url_protocol
end
