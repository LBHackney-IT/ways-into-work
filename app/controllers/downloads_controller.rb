class DownloadsController < ApplicationController

  def download
    file_upload = FileUpload.find(params[:id])
    if (file_upload.client_id == current_client.try(:id)) || current_advisor
      redirect_to file_upload.attachment.expiring_url(10)
    else
      not_authorised
    end
  end

end