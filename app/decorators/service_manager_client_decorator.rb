class ServiceManagerClientDecorator < ClientDecorator

  def client_profile_header
    "#{object.name}'s Profile"
  end
end
