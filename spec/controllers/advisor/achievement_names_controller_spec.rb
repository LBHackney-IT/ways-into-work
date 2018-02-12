# -*- encoding : utf-8 -*-

require 'spec_helper'

describe Advisor::AchievementNamesController, type: :controller do
  describe 'Finding achievement names for autocomplete' do
    let!(:achievement) { Fabricate(:achievement, name: 'test dsghjadsagdhja') }

    it 'gets the default names when searhing with one letter' do
      get :index, params: { term: 'd' }
      expect(response.content_type).to eq 'application/json'
      expect(response.status).to eql(200)
      body = JSON.parse(response.body)
      expect(body.sort).to eq(AchievementOption.all.collect(&:name).sort)
    end

    it 'gets achievement name with second word search term' do
      get :index, params: { term: 'dsghjadsagdhja' }
      expect(response.content_type).to eq 'application/json'
      expect(response.status).to eql(200)
      expect(JSON.parse(response.body).first['name']).to eq(achievement.name)
    end
  end
end
