class Advisor::EnquiriesController < Advisor::BaseController

  expose :opportunity
  expose :enquiry
  expose :enquiries, ->{ Enquiry.all }

  def index
    @enquiries_awaiting = Enquiry.awaiting
    @enquiries_reviewed = Enquiry.reviewed
  end

  def for_client
    @client = Client.find(params[:client_id])
    render 'for_client'
  end

  def show
    @client = enquiry.client
    session[:return_to] = request.referrer
  end

  def update
    if enquiry.update_attributes(enquiry_params)
      flash[:success] = "Enquiry review updated"
      redirect_to session[:return_to]
    else
      render 'show'
    end
  end

  def enquiry_params
    params.require(:enquiry).permit(:feedback, :status)
  end

end
