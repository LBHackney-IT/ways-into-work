class Advisor::ContactNotesController < Advisor::BaseController
  expose :client, decorate: ->(client) { client.decorate }

  expose :contact_note

  def index
    init_contact_note
  end

  def new
    init_contact_note
  end

  def create
    if contact_note.save
      flash[:success] = "Saved details of your contact with #{client.name}"
      redirect_to :advisor_my_clients
    else
      flash[:error] = 'Failed to save contact details'
      render :new
    end
  end

  private

  def contact_note_params
    params.require(:contact_note).permit(
      :advisor_id,
      :client_id,
      :content,
      :contact_method
    )
  end

  def init_contact_note
    contact_note.advisor_id = current_advisor.id
    contact_note.client_id = params[:client_id]
    contact_note.contact_method = client.preferred_contact_methods
  end
end
