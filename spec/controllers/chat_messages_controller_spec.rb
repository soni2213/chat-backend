# frozen_string_literal: true

require 'rails_helper'

describe Api::ChatMessagesController, type: :request do
  let(:user) { create(:user) }
  let(:channel) { create(:channel) }
  let(:chat_messages) { create_list(:chat_message, 4, user: user, channel: channel) }

  describe 'send a message' do
    context 'when user is not part of the channel' do
      before do
        login_with_api(user)
        post "/api/channels/#{channel.id}/chat_messages", headers: {
          Authorization: response.headers['Authorization']
        }
      end
      it 'returns 404' do
        expect(response.status).to eq(404)
      end
    end

    context 'when user is part of the channel' do
      before do
        login_with_api(user)
        create(:channel_user, channel: channel, user: user)
        post "/api/channels/#{channel.id}/chat_messages", params: {
          chat_message: { text: 'some random text' }
        }, headers: {
          Authorization: response.headers['Authorization']
        }
      end

      it 'returns 200' do
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'list all messages of a channel' do
    context 'when user is not part of the channel' do
      before do
        login_with_api(user)
        get "/api/channels/#{channel.id}/chat_messages", headers: {
          Authorization: response.headers['Authorization']
        }
      end
      it 'returns 404' do
        expect(response.status).to eq(404)
      end
    end

    context 'when user is part of the channel' do
      before do
        login_with_api(user)
        create(:channel_user, channel: channel, user: user)
        chat_messages
        get "/api/channels/#{channel.id}/chat_messages", headers: {
          Authorization: response.headers['Authorization']
        }
      end

      it 'returns 200' do
        expect(response.status).to eq(200)
      end

      it 'returns channel data' do
        expected_result = chat_messages.sort_by(&:id).reverse.as_json(only: %i[id text user_id channel_id])
        expect(json['resource']).to eq(expected_result)
      end
    end
  end
end
