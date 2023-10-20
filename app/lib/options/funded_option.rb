class FundedOption < Option
  def self.all
    [
      new('multi_agency_partnership', 'MAP (Multi Agency Partnership)'),
      new('flexible_support_fund', 'FSF (Flexible Support Fund)'),
      new('supported_employment', 'SE (Supported Employment)'),
      new('hackney_works_general', 'HW (Hackney Works - General)'),
      new('european_social_fund', 'ESF (European Social Fund)'),
      new('integrated_communities', 'IC (Integrated Communities)'),
      new('adult_learning_intervention', 'ALI (Adult Learning Intervention)'),
      new('public_health_individual_placement_support', 'PH.IPS (Public Health-Individual Placement and Support)'),
      new('primary_care_individual_placement_support', 'IPSPC (Individual Placement & Support in Primary Care)')
    ]
  end
end
