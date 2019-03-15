class FileUpload < ApplicationRecord
  has_attached_file :attachment, preserve_files: true
  
  # acts_as_paranoid
  include Discard::Model
  self.discard_column = :deleted_at

  validates_attachment_content_type :attachment, content_type: /\A.*\Z/

  validates_with AttachmentPresenceValidator, attributes: :attachment

  validates :client, presence: true

  belongs_to :client
  
  before_destroy :remove_file

  def file_type
    case attachment_content_type
    when /image\/.*/ then 'image'
    when 'application/pdf' then 'pdf'
    when 'application/msword' then 'word'
    when /ms-?word/ then 'word'
    when /officedocument/ then 'word'
    else 'generic'
    end
  end
  
  private
  
  def remove_file
    attachment.s3_bucket.object(attachment.path.sub(%r{\A/}, '')).delete
  end
end
