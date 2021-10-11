# frozen_string_literal: true

require 'rails_helper'

describe Api::ChannelsController, type: :request do
  let(:user) { create(:user) }
  let!(:channels) { create_list(:channel, 2) }

  context 'When fetching all channels' do
    before do
      login_with_api(user)
      get '/api/channels', headers: {
        Authorization: response.headers['Authorization']
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns the response as an array' do
      expect(json['resource']).to eq(channels.as_json(only: %i[id name]))
    end
  end

  context 'When fetching only joined channels, when have not joined any channel' do
    before do
      login_with_api(user)
      get '/api/channels?joined=true', headers: {
        Authorization: response.headers['Authorization']
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns the response as an array' do
      expect(json['resource']).to eq([])
    end
  end

  context 'When fetching only joined channels, when joined channels are there' do
    before do
      create(:channel_user, user: user, channel: channels.first)
      login_with_api(user)
      get '/api/channels?joined=true', headers: {
        Authorization: response.headers['Authorization']
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns the response as an array' do
      expect(json['resource']).to eq([channels.first.as_json(only: %i[id name])])
    end
  end
end
