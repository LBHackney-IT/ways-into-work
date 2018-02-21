class TypeOfWorkOption < Option
  def self.all # rubocop:disable  Metrics/AbcSize, Metrics/MethodLength
    [
      new('admin', 'Administration'),
      new('catering', 'Catering'),
      new('childcare', 'Childcare'),
      new('voluntary', 'Charities / voluntary sector'),
      new('cleaning', 'Cleaning'),
      new('driver', 'Driver'),
      new('media', 'Creative / media'),
      new('customer_service', 'Customer service'),
      new('engineering_construction', 'Engineering / construction'),
      new('finance', 'Finance / accounting'),
      new('facilities', 'Facilities / property'),
      new('health_social_care', 'Health and social care'),
      new('hospitality', 'Hospitality'),
      new('housing', 'Housing'),
      new('hr', 'HR'),
      new('manual_trades', 'Manual trades'),
      new('manufacturing', 'Manufacturing'),
      new('marketing', 'Marketing'),
      new('retail', 'Retail'),
      new('security', 'Security'),
      new('sport_leisure', 'Sport / leisure'),
      new('teaching', 'Teaching / teaching assistant'),
      new('tech_it', 'Tech / IT'),
      new('travel', 'Travel and logistics'),
      new('warehouse', 'Warehouse operative'),
      new('youth', 'Youth work')
    ]
  end
end
