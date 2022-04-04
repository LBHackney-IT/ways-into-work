class FundedOption < Option
  def self.all
    [
      new('multi_agency_partnership', 'MAP (Multi Agency Partnership)'),
      new('flexible_support_fund', 'FSF (Flexible Support Fund)'),
      new('supported_employment', 'SE (Supported Employment)'),
      new('hackney_works_general', 'HW (Hackney Works - General)'),
      new('european_social_fund', 'ESF (European Social Fund)'),
      new('integrated_communities', 'IC (Integrated Communities)')
    ]
  end
end