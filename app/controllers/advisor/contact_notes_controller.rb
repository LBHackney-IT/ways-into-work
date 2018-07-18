class Advisor::ContactNotesController < Advisor::BaseController
  expose :client, decorate: ->(client) { client.decorate }

  expose :contact_note

  def index; end

  def new
    init_contact_note
  end
  
  def edit; end
  
  def update
    if contact_note.update(contact_note_params)
      flash[:success] = "Your contact note for #{client.name} has been updated"
      redirect_to advisor_client_contact_notes_path(client_id: client.id)
    else
      flash[:error] = 'Failed to save contact note'
      render :edit
    end
  end

  def create
    if contact_note.save
      flash[:success] = "Your contact note for #{client.name} has been saved"
      redirect_to user_root
    else
      flash[:error] = 'Failed to save contact note'
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
  end
end
