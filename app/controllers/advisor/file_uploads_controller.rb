class Advisor::FileUploadsController < Advisor::BaseController

  expose :file_upload
  expose :client
  expose :new_file_upload, -> { client.file_uploads.build(uploaded_by: current_advisor.name) }

  def new
  end

  def create
    if file_upload.save
      redirect_to edit_advisor_client_path(id: file_upload.client_id)
    else
      render 'new'
    end
  end

  def destroy
    file_upload.destroy
    flash[:success] = 'File deleted'
    redirect_to edit_advisor_client_path(id: params[:client_id])
  end

  def file_upload_params
    params.require(:file_upload).permit(
        :client_id,
        :attachment,
        :uploaded_by
      )
  end

end
