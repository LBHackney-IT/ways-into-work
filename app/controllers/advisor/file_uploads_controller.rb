class Advisor::FileUploadsController < Advisor::BaseController
  expose :file_upload
  expose :client, decorate: ->(client) { AdvisorClientDecorator.decorate(client) }

  def new
    file_upload.client_id = client.id
    file_upload.uploaded_by = current_advisor.name
    render 'shared/file_uploads/new'
  end

  def create
    if file_upload.save
      redirect_to new_advisor_client_file_upload_path(client)
    else
      render 'shared/file_uploads/new'
    end
  end

  def destroy
    file_upload.really_destroy!
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
