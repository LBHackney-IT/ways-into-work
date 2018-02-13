require 'spec_helper'

RSpec.describe DashboardStats, type: :model do
  let(:hub1) { Fabricate(:homerton_hub) }
  let(:hub2) { Fabricate(:hub) }
  let(:advisor) { Fabricate(:advisor, hub: hub1) }
  let(:advisor2) { Fabricate(:advisor, hub: hub1) }

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

  let(:from_date) { Time.zone.now.beginning_of_month }
  let(:to_date) { Time.zone.now.end_of_month }
  let(:options) { {} }
  let(:subject) { described_class.new(from_date, to_date, options) }

  it 'gets a registered count' do
    expect(subject.registered).to eq(4)
  end

  context 'with hub set' do
    let(:options) { { hub: hub1.id } }

    it 'gets a registered count' do
      expect(subject.registered).to eq(2)
    end
  end

  context 'with advisor set' do
    let(:options) { { advisor: advisor.id } }

    it 'gets a registered count' do
      expect(subject.registered).to eq(1)
    end
  end

  context 'with funding code set' do
    let(:options) { { funding_code: 'supported_employment' } }

    it 'gets the correct count' do
      Fabricate.times(3, :client, funded: %w[troubled_families supported_employment])
      Fabricate.times(2, :client, funded: %w[troubled_families])
      expect(subject.registered).to eq(3)
    end
  end

  context 'with month set' do
    let(:from_date) { 1.month.ago.beginning_of_month }
    let(:to_date) { 1.month.ago.end_of_month }

    it 'gets a registered count' do
      expect(subject.registered).to eq(7)
    end

    context 'with hub set' do
      let(:options) { { hub: hub1.id } }

      it 'gets a registered count' do
        expect(subject.registered).to eq(3)
      end
    end
  end

  context 'with equalities set' do
    let(:workless_on_benefits) { Fabricate.times(rand(1..10), :client, receive_benefits: true, employed: true) }
    let(:workless_off_benefits) { Fabricate.times(rand(1..10), :client, receive_benefits: false, employed: false) }
    let(:under_25) { Fabricate.times(rand(1..10), :client, date_of_birth: Time.zone.today - 20.years) }
    let(:over_50) { Fabricate.times(rand(1..10), :client, date_of_birth: Time.zone.today - 55.years) }
    let(:care_leavers) { Fabricate.times(rand(1..10), :client, care_leaver: 'Yes') }
    let(:health_conditions) { Fabricate.times(rand(1..10), :client, health_condition: 'Yes') }
    let(:female) { Fabricate.times(rand(1..10), :client, gender: 'Female') }
    let(:bame) { Fabricate.times(rand(1..10), :client, bame: 'black') }

    %w[
      workless_on_benefits
      workless_off_benefits
      under_25
      over_50
      care_leavers
      health_conditions
      female
      bame
    ].each do |option|

      context "with #{option}" do
        let(:options) { { equalities: option } }

        it 'gets a registered count' do
          send(option)
          expect(subject.registered).to eq(send(option).count)
        end
      end
    end
  end

  context 'outcomes' do
    let!(:job_start_clients) do
      Fabricate.times(4, :client) do
        achievements do
          [
            Fabricate(:achievement,
                      name: 'job_apprenticeship',
                      date_achieved: rand(Time.zone.now.beginning_of_month..Time.zone.now.end_of_month))
          ]
        end
      end
    end

    it 'gets client count for an outcome' do
      expect(subject.with_outcome('job_apprenticeship')).to eq(4)
    end
  end

  it 'generates a CSV header' do
    expect(subject.csv_header).to eq(
      [
        'From date',
        'To date',
        'Registered',
        'CVs completed',
        'Job applications',
        'Interviews attended',
        'Placements attended',
        'Courses started',
        'Courses completed',
        'Job starts',
        'Job sustainments'
      ]
    )
  end

  it 'generates a csv row' do
    expect(subject.csv_row).to eq(
      [
        from_date.strftime('%Y-%m-%d'),
        to_date.strftime('%Y-%m-%d'),
        4,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0
      ]
    )
  end

  it 'generates a CSV' do
    csv = CSV.parse(subject.csv)
    expect(csv.count).to eq(13)
    expect(csv[0]).to eq(subject.csv_header)
    expect(csv.find { |r| r[0] == from_date.strftime('%Y-%m-%d') }.map(&:to_s)).to eq(subject.csv_row.map(&:to_s))
  end
end
