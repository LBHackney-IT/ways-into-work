class Advisor::AdvisorsController < Advisor::BaseController
  before_action :check_permissions!
  expose :advisor
  expose :advisors, -> { Advisor.all }
  
  def index; end

  def new
    advisor.build_login
  end

  def create
    advisor.login&.generate_default_password
    if advisor.save
      advisor.send_confirmation!
      flash[:success] = "#{advisor.name} created."
      redirect_to advisor_advisors_path
    else
      render :new
    end
  end
  
  def edit; end
  
  def update
    if advisor.update_attributes(advisor_params)
      flash[:success] = "#{advisor.name} updated."
      redirect_to advisor_advisors_path
    else
      render :edit
    end
  end
  
  def destroy
    advisor.destroy
    flash[:success] = "#{advisor.name} deleted."
    redirect_to advisor_advisors_path
  end

  private

  def check_permissions!
    not_authorised unless current_advisor.admin?
  end

  def advisor_params
    params.require(:advisor).permit(:name, :phone, :hub_id, :role, login_attributes: [:email])
  end
end
