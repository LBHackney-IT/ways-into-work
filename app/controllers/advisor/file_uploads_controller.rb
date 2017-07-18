class Advisor::FileUploadsController < Advisor::BaseController

  expose :file_upload
  expose :client

  def new
    file_upload.client = client
    file_upload.uploaded_by = current_advisor.name
  end

  def create
    if file_upload.save
      redirect_to new_advisor_client_file_upload_path(client)
    else
      render 'new'
    end
  end

  def destroy
    file_upload.destroy
    flash[:success] = 'File deleted'
    redirect_to new_advisor_client_file_upload_path(client)
  end

  def file_upload_params
    params.require(:file_upload).permit(
        :client_id,
        :attachment,
        :uploaded_by
      )
  end

end
