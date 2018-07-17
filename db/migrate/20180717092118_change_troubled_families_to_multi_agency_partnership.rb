class ChangeTroubledFamiliesToMultiAgencyPartnership < ActiveRecord::Migration[5.1]
  def change
    Client.where(':funded = ANY(funded)', funded: 'troubled_families').each do |c|
      c.funded[c.funded.index('troubled_families')] = 'multi_agency_partnership'
      c.save
    end
  end
end
