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

  def create # horrible method - to be refactored :)
    @enquiry = Enquiry.new(enquiry_params)
    @opportunity = Opportunity.find(params[:opportunity_id])
    @enquiry.client_id = current_client.id
    @enquiry.opportunity_id = @opportunity.id
    @file_upload = FileUpload.new(client_id: current_client.id, uploaded_by: current_client.name)

    if params[:enquiry][:file_upload_id].present? # Check they have seleted something - already uplaoded or new.
      if params[:enquiry][:file_upload_id] == "0" # If new file upload
        @file_upload = FileUpload.create(file_upload_params)
        if @file_upload.save # set file_upload_id on enquiry if created successfully
          @enquiry.file_upload_id = @file_upload.id
          if @enquiry.save
            flash[:notice] = "Your enquiry was sent successfully"
            render 'confirm'
          else
            flash[:notice] = "There was a problem with your enquiry"
            render 'new'
          end
        else
          @enquiry.file_upload_id = 0
          flash[:error] = "There was a problem with your file upload, did you select a file?"
          render 'new'
        end
      else # If existing file upload
        @enquiry.file_upload_id = params[:enquiry][:file_upload_id] # set file_upload_id on enquiry
        if @enquiry.save
          flash[:alert] = 'Your enquiry was sent successfully'
          render 'confirm'
        else
          flash[:notice] = "There was a problem with your enquiry"
          render 'new'
        end
      end
    else # If nothing selected render new with message
      flash[:notice] = "You must select a file to upload"
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
