class Advisor::ContactNotesController < Advisor::BaseController

  expose :client, decorate: ->(client){ client.decorate }
  expose :contact_note
  expose :new_contact_note, -> { client.contact_notes.build(advisor_id: current_advisor.id, contact_method: client.preferred_contact_method) }

  def new
  end

  def create
    if contact_note.save
      flash[:success] = "Contact Nor saved saved"
      redirect_to :advisor_my_clients
    else
      render :new
    end
  end

  private

  def contact_note_params
    params.require(:contact_note).permit(
      :advisor_id,
      :client_id,
      :content,
      :contact_method)
  end

end
