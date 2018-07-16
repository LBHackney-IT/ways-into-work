class Client::FileUploadsController < Client::BaseController
  expose :file_upload
  expose :client, -> { current_client.decorate }

  def new
    file_upload.client_id = client.id
    file_upload.uploaded_by = client.name
    render 'shared/file_uploads/new'
  end

  def create
    if file_upload.save
      redirect_to new_client_file_upload_path(client)
    else
      render 'shared/file_uploads/new'
    end
  end

  def destroy
    file_upload.really_destroy!
    flash[:success] = 'File deleted'
    redirect_to new_client_file_upload_path(client)
  end

  def file_upload_params
    params.require(:file_upload).permit(
      :client_id,
      :attachment,
      :uploaded_by
    )
  end
end
