class Advisor::FileUploadsController < Advisor::BaseController

  def new
    @client = Client.find(params[:client_id])
    @file = @client.file_uploads.build(uploaded_by: current_advisor.email)
  end

  def create
    @file = FileUpload.new(file_params)
    if @file.save
      redirect_to advisor_client_path(@file.client)
    else
      render 'new'
    end
  end

  def destroy
    FileUpload.find(params[:id]).destroy
    redirect_to new_advisor_client_file_upload_path(Client.find(params[:client_id]))
  end

  def file_params
    params.require(:file_upload).permit(
        :client_id,
        :attachment,
        :uploaded_by
      )
  end

end
