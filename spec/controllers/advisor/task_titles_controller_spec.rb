# -*- encoding : utf-8 -*-

require 'spec_helper'

describe Advisor::TaskTitlesController, type: :controller do
  describe 'Finding achievement titles for autocomplete' do
    it 'gets the default names when searhing with one letter' do
      get :index, params: { term: 'd' }
      expect(response.content_type).to eq 'application/json'
      expect(response.status).to eql(200)
      body = JSON.parse(response.body)
      expect(body.sort).to eq(AchievementOption.all.collect(&:name).sort)
    end

    it 'matches three based on typing job' do
      get :index, params: { term: 'job' }
      expect(response.content_type).to eq 'application/json'
      expect(response.status).to eql(200)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.count).to eq(3)
      expect(parsed_body).to eq(['Submit job application', 'Start job or apprenticeship', 'Stay in job more than 6 months'])
    end

    it 'matches none based on typing 3 characters' do
      get :index, params: { term: 'blah' }
      expect(response.content_type).to eq 'application/json'
      expect(response.status).to eql(200)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.count).to eq(0)
    end
  end
end
