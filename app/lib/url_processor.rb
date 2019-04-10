module UrlProcessor

  extend ActiveSupport::Concern

  def smart_add_url_protocol
    unless self.url[/^https?:\/\//]
      self.url = "http://#{self.url}"
    end
  end
end