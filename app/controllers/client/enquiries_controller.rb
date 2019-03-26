class Client::EnquiriesController < Client::BaseController

  expose :file_upload

  def new
    @enquiry = Enquiry.new
    @opportunity = Opportunity.find(params[:opportunity_id])
    file_upload.client_id = current_client.id
    file_upload.uploaded_by = current_client.name
  end

  def create # horrible method - to be refactored :)
    @enquiry = Enquiry.new(enquiry_params)
    @enquiry.client_id = current_client.id
    @enquiry.opportunity_id = params[:opportunity_id]

    if params[:enquiry][:file_upload_id].present? # Check they have seleted something - already uplaoded or new.
      if params[:enquiry][:file_upload_id] == "0" # If new file upload
        file_upload = FileUpload.create(file_upload_params)
        if file_upload.save # set file_upload_id on enquiry if created successfully
          @enquiry.file_upload_id = file_upload.id
          if @enquiry.save
            flash[:notice] = "Your enquiry was sent successfully"
            render 'confirm'
          else
            flash[:notice] = "There was a problem with your enquiry"
            render 'new'
          end
        else
          flash[:notice] = "There was a problem with your enquiry"
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
      @opportunity = Opportunity.find(params[:opportunity_id])
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
