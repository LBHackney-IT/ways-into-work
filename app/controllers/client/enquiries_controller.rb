class Client::EnquiriesController < Client::BaseController

  def new
    @enquiry = Enquiry.new
    @enquiry.opportunity_id = params[:opportunity_id]
    @enquiry.opportunity_type = params[:opportunity_type]
  end

  def create
    @enquiry = Enquiry.new(enquiry_params)
    @enquiry.client_id = current_client.id
    if @enquiry.save
      flash[:alert] = 'Thank you for registering your interest in this opportunity. Our Hackney Works team will review your submission and get in touch if you are being considered for the role.'
      redirect_to client_opportunities_path
    else
      render 'new'
    end
  end

  def enquiry_params
    params.require(:enquiry).permit(:client_id, :opportunity_id, :opportunity_type, :supporting_statement)
  end

end