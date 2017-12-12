class FundedOption < Option
  def self.all # rubocop:disable Metrics/MethodLength
    [
      new('troubled_families', 'TF (Troubled Families)'),
      new('flexible_support_fund', 'FSF (Flexible Support Fund)'),
      new('supported_employment', 'SE (Supported Employment)'),
      new('hackney_works_general', 'HW (Hackney Works - General)'),
      new('european_social_fund', 'ESF (European Social Fund)'),
      new('unlocking_opportunities', 'UO (Unlocking Opportunities)')
    ]
  end
end