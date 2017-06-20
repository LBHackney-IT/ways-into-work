class ClientDecorator < Draper::Decorator

  delegate_all

  def client_profile_header
    'Your Profile'
  end

end
