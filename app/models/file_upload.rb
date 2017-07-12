class FileUpload < ApplicationRecord

  has_attached_file :attachment

  validates_attachment_content_type :attachment, :content_type => /\A.*\Z/

  validates_with AttachmentPresenceValidator, :attributes => :attachment

  validates :client, presence: true

  belongs_to :client

  def file_type
    case attachment_content_type
      when /image\/.*/ then "image"
      when "application/pdf" then "pdf"
      when "application/msword" then "word"
      when /ms-?word/ then "word"
      when /officedocument/ then "word"
      else "generic"
    end
  end

end
