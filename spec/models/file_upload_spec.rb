require 'spec_helper'

RSpec.describe FileUpload, type: :model do
  
  let(:subject) { Fabricate.build(:file_upload) }
  
  describe '#file_type'
  {
    'image/png' => 'image',
    'application/pdf' => 'pdf',
    'application/msword' => 'word',
    'application/vnd.ms-word.document.macroEnabled.12' => 'word',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document' => 'word',
    'text/plain' => 'generic'
  }.each do |k, v|
    it "returns a correct file type for #{k}" do
      subject.attachment_content_type = k
      expect(subject.file_type).to eq(v)
    end
  end
  
end
