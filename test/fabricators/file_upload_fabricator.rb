Fabricator(:file_upload) do
  attachment { File.new Rails.root.join('features', 'upload_files', 'CV.doc') }
end
