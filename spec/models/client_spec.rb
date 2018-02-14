require 'spec_helper'

RSpec.describe Client, type: :model do
  context 'search by name' do
    let(:client1) { Fabricate.create(:client, first_name: 'Katherine') }
    let(:client2) { Fabricate.create(:client, last_name: 'Robynson') }
    let(:client3) { Fabricate.create(:client, first_name: 'Muhammad') }

    it 'is not fussy about spellings' do
      expect(Client.search_query('Catherine')).to match_array([client1])
      expect(Client.search_query('Robynson')).to match_array([client2])
      expect(Client.search_query('Mohammed')).to match_array([client3])
      expect(Client.search_query('muhammad')).to match_array([client3])
    end
  end

  context 'csv' do
    let(:advisor) { Fabricate.create(:advisor, name: 'Advisor McAdvisorface') }
    let(:client) do
      Fabricate.create(:client,
                       first_name: 'Client',
                       last_name: 'McClientface',
                       login: Fabricate.create(:user_login, email: 'login@example.com'),
                       advisor: advisor,
                       funded: %w[hackney_works_general troubled_families],
                       objectives: %w[full_time_work],
                       rag_status: 'amber',
                       types_of_work: %w[catering],
                       bame: 'mixed',
                       gender: 'Male',
                       date_of_birth: Time.zone.now - 25.years,
                       affected_by_benefit_cap: true,
                       assigned_supported_employment: false,
                       health_condition: 'Prefer not to say',
                       care_leaver: 'No',
                       employed: true,
                       meetings: [Fabricate.build(:meeting, agenda: 'initial_assessment', client_attended: true)],
                       referrer: Fabricate(:referrer, email: 'referrer@example.com'),
                       achievements: [Fabricate(:achievement, name: 'training_started'),
                                      Fabricate.times(3, :achievement, name: 'interview'),
                                      Fabricate.times(2, :achievement, name: 'job_start'),
                                      Fabricate(:achievement, name: 'job_sustained')].flatten)
    end
    let(:clients) { Fabricate.times(10, :client) }

    it 'generates a CSV row' do
      expect(client.csv_row).to eq([
        Time.zone.now.to_date,
        client.meetings.first.start_datetime.to_date,
        nil,
        'Advisor McAdvisorface',
        'Client McClientface',
        'login@example.com',
        'hackney_works_general, troubled_families',
        'full_time_work',
        'amber',
        'catering',
        'Mixed',
        'Male',
        (Time.zone.now - 25.years).to_date,
        'Yes',
        'No',
        'Prefer not to say',
        nil,
        'No',
        'Yes',
        'referrer@example.com',
        0,
        0,
        3,
        0,
        1,
        0,
        2,
        1
      ])
    end

    it 'generates a csv header with all the achievement options' do
      expect(AchievementOption.all.collect(&:name) - Client.csv_header).to be_empty
    end

    it 'generates an entire CSV' do
      csv = CSV.parse Client.csv(clients)
      expect(csv.count).to eq(11)
      expect(csv.shift).to eq(Client.csv_header)
      expect(csv.count).to eq(10)
    end
  end

  describe 'scopes' do
    let(:new_date) do
      rand(Time.zone.now.beginning_of_month..Time.zone.now.end_of_month)
    end

    let(:old_date) do
      rand(1.month.ago.beginning_of_month..1.month.ago.end_of_month)
    end

    describe 'by_hub_id' do
      let(:hub1) { Fabricate(:homerton_hub) }
      let(:hub2) { Fabricate(:hub) }
      let!(:hub1_clients) do
        Fabricate.times(5, :client,
                        advisor: Fabricate(:advisor, hub: hub1))
      end
      let!(:hub2_clients) do
        Fabricate.times(5, :client,
                        advisor: Fabricate(:advisor, hub: hub2))
      end

      it 'gets clients for a hub' do
        expect(Client.by_hub_id(hub1.id)).to match_array(hub1_clients)
        expect(Client.by_hub_id(hub2.id)).to match_array(hub2_clients)
      end
    end

    describe 'initial_assessments_attended' do
      let!(:client_attended) { Fabricate.create(:client) }
      let!(:client_not_attended) { Fabricate.create(:client) }

      let!(:meeting_attended) do
        Fabricate(:meeting, client: client_attended, client_attended: true, start_datetime: new_date, agenda: 'initial_assessment')
      end
      let!(:meeting_not_attended) do
        Fabricate(:meeting, client: client_not_attended, client_attended: false, start_datetime: new_date, agenda: 'initial_assessment')
      end
      let!(:meeting_attended1) do
        Fabricate(:meeting, client: client_not_attended, client_attended: true, start_datetime: old_date, agenda: 'initial_assessment')
      end
      let!(:meeting_attended2) { Fabricate(:meeting, client: client_not_attended, client_attended: true, start_datetime: new_date) }

      it 'only gets initial assessment meeting that was attended in the time frame' do
        expect(
          Client.initial_assessments_attended(Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
        ).to match_array([client_attended])
      end
    end

    describe 'registered_on' do
      let!(:new_clients) { Fabricate.times(5, :client, created_at: new_date) }

      let!(:old_clients) { Fabricate.times(5, :client, created_at: old_date) }

      it 'gets clients registered this month' do
        expect(Client.registered_on(Time.zone.now.beginning_of_month)).to match_array(new_clients)
      end

      it 'gets clients registered last month' do
        expect(Client.registered_on(1.month.ago.beginning_of_month)).to match_array(old_clients)
      end

      it 'gets clients registered within a date range' do
        expect(
          Client.registered_on(1.month.ago.beginning_of_month, new_date.end_of_day)
        ).to match(new_clients + old_clients)
      end
    end

    describe 'with_outcome' do
      let!(:job_start_clients) do
        Fabricate.times(4, :client) do
          achievements do
            [
              Fabricate(:achievement,
                        name: 'job_apprenticeship',
                        created_at: rand(Time.zone.now.beginning_of_month..Time.zone.now.end_of_month))
            ]
          end
        end
      end

      let!(:old_job_start_clients) do
        ActionPlanTask.skip_callback(:save, :before, :check_completion)
        clients = Fabricate.times(8, :client) do
          achievements do
            [
              Fabricate(:achievement,
                        name: 'job_apprenticeship',
                        created_at: rand(1.month.ago.beginning_of_month..1.month.ago.end_of_month))
            ]
          end
        end
        ActionPlanTask.set_callback(:save, :before, :check_completion)
        clients
      end

      it 'gets clients with a job start' do
        expect(
          Client.with_outcome('job_apprenticeship', Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
        ).to match_array(job_start_clients)

        expect(
          Client.with_outcome('job_apprenticeship', 1.month.ago.beginning_of_month, 1.month.ago.end_of_month)
        ).to match_array(old_job_start_clients)
      end
    end

    describe 'by_funding_code' do
      let!(:clients) { Fabricate.times(5, :client, funded: %w[troubled_families supported_employment]) }
      let!(:other_clients) { Fabricate.times(5, :client, funded: %w[supported_employment]) }

      it 'gets the correct clients' do
        expect(Client.by_funding_code('troubled_families')).to eq(clients)
        expect(Client.by_funding_code('supported_employment')).to eq(clients + other_clients)
      end

      it 'gets all by default' do
        expect(Client.by_funding_code(nil)).to eq(clients + other_clients)
      end
    end

    describe 'by_rag_status' do
      let!(:green_clients) { Fabricate.times(5, :client, rag_status: 'green') }
      let!(:red_clients) { Fabricate.times(3, :client, rag_status: 'red') }

      it 'filters by rag status' do
        expect(Client.by_rag_status('green')).to eq(green_clients)
        expect(Client.by_rag_status('red')).to eq(red_clients)
      end
    end

    describe 'by_objective' do
      let!(:apprenticeships) { Fabricate.times(5, :client, objectives: %w[apprenticeship training_qualification]) }
      let!(:training_qualifications) { Fabricate.times(3, :client, objectives: %w[training_qualification]) }

      it 'filters by objective' do
        expect(Client.by_objective('apprenticeship')).to match_array(apprenticeships)
        expect(Client.by_objective('training_qualification')).to match_array(apprenticeships + training_qualifications)
      end
    end

    describe 'sorted_by' do
      let(:clients) { Client.all }

      describe 'name' do
        before do
          Fabricate(:client, first_name: 'Adam')
          Fabricate(:client, first_name: 'Zebedee')
          Fabricate(:client, first_name: 'Clare')
        end

        it 'sorts by name ascending' do
          expect(clients.sorted_by('first_name_asc')[0].first_name).to eq('Adam')
          expect(clients.sorted_by('first_name_asc')[1].first_name).to eq('Clare')
          expect(clients.sorted_by('first_name_asc')[2].first_name).to eq('Zebedee')
        end

        it 'sorts by name descending' do
          expect(clients.sorted_by('first_name_desc')[0].first_name).to eq('Zebedee')
          expect(clients.sorted_by('first_name_desc')[1].first_name).to eq('Clare')
          expect(clients.sorted_by('first_name_desc')[2].first_name).to eq('Adam')
        end
      end

      describe 'advisor' do
        before do
          Fabricate(:client, advisor: Fabricate(:advisor, name: 'Adam'))
          Fabricate(:client, advisor: Fabricate(:advisor, name: 'Zebedee'))
          Fabricate(:client, advisor: Fabricate(:advisor, name: 'Clare'))
        end

        it 'sorts by advisor ascending' do
          expect(clients.sorted_by('advisor_asc')[0].advisor.name).to eq('Adam')
          expect(clients.sorted_by('advisor_asc')[1].advisor.name).to eq('Clare')
          expect(clients.sorted_by('advisor_asc')[2].advisor.name).to eq('Zebedee')
        end

        it 'sorts by advisor descending' do
          expect(clients.sorted_by('advisor_desc')[0].advisor.name).to eq('Zebedee')
          expect(clients.sorted_by('advisor_desc')[1].advisor.name).to eq('Clare')
          expect(clients.sorted_by('advisor_desc')[2].advisor.name).to eq('Adam')
        end
      end

      describe 'rag status' do
        before do
          Fabricate(:client, rag_status: 1)
          Fabricate(:client, rag_status: 0)
          Fabricate(:client, rag_status: 0)
          Fabricate(:client, rag_status: 3)
          Fabricate(:client, rag_status: 2)
        end

        it 'sorts by rag status ascending' do
          expect(clients.sorted_by('rag_status_asc')[0].rag_status).to eq('green')
          expect(clients.sorted_by('rag_status_asc')[1].rag_status).to eq('amber')
          expect(clients.sorted_by('rag_status_asc')[2].rag_status).to eq('red')
          expect(clients.sorted_by('rag_status_asc')[3].rag_status).to eq('un_assessed')
          expect(clients.sorted_by('rag_status_asc')[4].rag_status).to eq('un_assessed')
        end

        it 'sorts by rag status descending' do
          expect(clients.sorted_by('rag_status_desc')[0].rag_status).to eq('un_assessed')
          expect(clients.sorted_by('rag_status_desc')[1].rag_status).to eq('un_assessed')
          expect(clients.sorted_by('rag_status_desc')[2].rag_status).to eq('red')
          expect(clients.sorted_by('rag_status_desc')[3].rag_status).to eq('amber')
          expect(clients.sorted_by('rag_status_desc')[4].rag_status).to eq('green')
        end
      end

      describe 'next_meeting_date' do
        let!(:client_list) do
          [
            Fabricate(:client, next_meeting_date: Time.zone.now + 1.day),
            Fabricate(:client, next_meeting_date: Time.zone.now + 10.days),
            Fabricate(:client, next_meeting_date: Time.zone.now),
            Fabricate(:client, next_meeting_date: Time.zone.now + 3.days),
            Fabricate(:client, next_meeting_date: Time.zone.now + 4.days)
          ]
        end

        it 'sorts by next meeting date ascending' do
          expect(clients.sorted_by('next_meeting_date_asc')[0]).to eq(client_list[2])
          expect(clients.sorted_by('next_meeting_date_asc')[1]).to eq(client_list[0])
          expect(clients.sorted_by('next_meeting_date_asc')[2]).to eq(client_list[3])
          expect(clients.sorted_by('next_meeting_date_asc')[3]).to eq(client_list[4])
          expect(clients.sorted_by('next_meeting_date_asc')[4]).to eq(client_list[1])
        end

        it 'sorts by next meeting date descending' do
          expect(clients.sorted_by('next_meeting_date_desc')[0]).to eq(client_list[1])
          expect(clients.sorted_by('next_meeting_date_desc')[1]).to eq(client_list[4])
          expect(clients.sorted_by('next_meeting_date_desc')[2]).to eq(client_list[3])
          expect(clients.sorted_by('next_meeting_date_desc')[3]).to eq(client_list[0])
          expect(clients.sorted_by('next_meeting_date_desc')[4]).to eq(client_list[2])
        end
      end
    end
  end

  it 'can have a referrer' do
    referrer = Fabricate.create(:referrer)
    client = Fabricate.create(:client, referrer: referrer)
    expect(client.referrer).to eq(referrer)
  end
end
