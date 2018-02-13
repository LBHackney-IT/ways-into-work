class Advisor::AdvisorController < Advisor::BaseController
  before_action :check_permissions!
  expose :advisor

  def new
    advisor.build_login
  end

  def create
    advisor.login.generate_default_password
    if advisor.save
      advisor.send_confirmation!
      flash[:success] = "#{advisor.name} created."
      redirect_to user_root
    else
      render :new
    end
  end

  private

  def check_permissions!
    not_authorised unless current_advisor.admin?
  end

  def advisor_params
    params.require(:advisor).permit(:name, :phone, :hub_id, :role, login_attributes: [:email])
  end
end
