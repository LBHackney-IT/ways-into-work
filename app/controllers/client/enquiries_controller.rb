class Client::EnquiriesController < Client::BaseController

  def new
    @enquiry = Enquiry.new
    @opportunity = Opportunity.find(params[:opportunity_id])
    if @opportunity.enquired_for_by_client? current_client
      flash[:notice] = "You have already enquired about this opportunity"
      redirect_to opportunity_path(@opportunity)
    end
    @file_upload = FileUpload.new(client_id: current_client.id, uploaded_by: current_client.name)
  end

  def create
    @enquiry = Enquiry.new(enquiry_params)
    @opportunity = Opportunity.find(params[:opportunity_id])
    @enquiry.client_id = current_client.id
    @enquiry.opportunity_id = @opportunity.id
    @file_upload = FileUpload.new(client_id: current_client.id, uploaded_by: current_client.name)

    if params[:enquiry][:file_upload_id] == "0" # If new file upload
      @file_upload = FileUpload.new(file_upload_params)
      if @file_upload.save # set file_upload_id on enquiry if upload created successfully
        @enquiry.file_upload_id = @file_upload.id
      else # If selected new file upload but then didnt actually upload anything
        @enquiry.file_upload_id = 0
        flash[:error] = "There was a problem with your file upload, did you select a file?"
        render 'new'
        return
      end
    else # If existing file upload
      @enquiry.file_upload_id = params[:enquiry][:file_upload_id] # set file_upload_id on enquiry
    end

    if @enquiry.save
      flash[:alert] = 'Your enquiry was sent successfully'
      ClientMailer.confirm_enquiry(current_client, @opportunity).deliver_now
      render 'confirm'
    else
      flash[:notice] = "There was a problem with your enquiry"
      render 'new'
    end

  end

  def enquiry_params
    params.require(:enquiry).permit(:client_id, :opportunity_id, :supporting_statement)
  end

  def file_upload_params
    params.require(:file_upload).permit(:client_id, :attachment, :uploaded_by)
  end

end
