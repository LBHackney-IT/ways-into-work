require 'spec_helper'

RSpec.describe Advisor::DashboardController, type: :controller do
  let(:hub1) { Fabricate(:homerton_hub) }
  let(:hub2) { Fabricate(:hub) }
  let(:advisor) { Fabricate(:advisor, hub: hub1) }
  let(:advisor2) { Fabricate(:advisor, hub: hub1) }

  before { sign_in(advisor.login) }

  before do
    Fabricate.times(1, :client, advisor: advisor)
    Fabricate.times(1, :client, advisor: advisor2)
    Fabricate.times(2, :client, advisor: Fabricate(:advisor, hub: hub2))
    Fabricate.times(3, :client,
                    advisor: Fabricate(:advisor, hub: hub1),
                    created_at: 1.month.ago)
    Fabricate.times(4, :client,
                    advisor: Fabricate(:advisor, hub: hub2),
                    created_at: 1.month.ago)
  end

  describe '#index' do
    context 'with defaults' do
      let!(:subject) { get :index }

      it 'sets the month to this month' do
        expect(assigns(:month)).to eq(Time.zone.today.month)
      end

      it 'sets the year to this year' do
        expect(assigns(:year)).to eq(Time.zone.today.year)
      end

      it 'does not set a hub' do
        expect(assigns(:hub)).to be_nil
      end
    end

    context 'with quarter set' do
      {
        'Q1' => [
          Time.zone.parse('2017-04-01'),
          Time.zone.parse('2017-06-30')
        ],
        'Q2' => [
          Time.zone.parse('2017-07-01'),
          Time.zone.parse('2017-09-30')
        ],
        'Q3' => [
          Time.zone.parse('2017-10-01'),
          Time.zone.parse('2017-12-31')
        ],
        'Q4' => [
          Time.zone.parse('2018-01-01'),
          Time.zone.parse('2018-03-31')
        ]
      }.each do |quarter, dates|
        it "sets the right from and to dates for #{quarter}" do
          get :index, params: {
            month: quarter,
            year: 2017
          }
          expect(assigns(:from)).to eq(dates[0])
          expect(assigns(:to)).to eq(dates[1])
        end
      end
    end

    it 'generates a csv' do
      get :index, format: :csv
      csv = CSV.parse(response.body)
      expect(csv.count).to eq(13)
    end
  end
end
