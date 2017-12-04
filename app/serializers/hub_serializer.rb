class HubSerializer < ActiveModel::Serializer
  attributes :lon, :lat, :hub_id, :name, :street
  
  def lon
    object.longitude
  end
  
  def lat
    object.latitude
  end
  
  def hub_id
    object.id
  end
  
  def street
    object.address_line_1
  end
end
