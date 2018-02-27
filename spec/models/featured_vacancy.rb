require 'spec_helper'

RSpec.describe FeaturedVacancy, type: :model do
  let(:featured_vacancy) { Fabricate.create(:featured_vacancy) }
  let(:vacancy) { Fabricate.create(:vacancy) }
  
  it 'has a vacancy' do
    featured_vacancy.vacancy = vacancy
    featured_vacancy.save
    featured_vacancy.reload
    expect(featured_vacancy.vacancy).to eq(vacancy)
  end
  
end
