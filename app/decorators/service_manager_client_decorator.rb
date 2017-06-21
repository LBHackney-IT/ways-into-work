class ServiceManagerClientDecorator < ClientDecorator

  def client_profile_header
    "#{client.name}'s Profile"
  end
end
