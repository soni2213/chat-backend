# frozen_string_literal: true

module Api
  class ChatMessagesController < Api::BaseController
    before_action :set_channel, only: %i[index create]

    def create
      current_user.chat_messages.create!(chat_message_params)
      render_success(message: 'successful')
    end

    def index
      messages = @channel.chat_messages.order(id: :desc).page(params[:page])
      render_success(
        resource: messages.as_json(only: %i[id text channel_id user_id]),
        message: 'successful'
      )
    end

    private

    def chat_message_params
      params.require(:chat_message)
            .permit(:text)
            .merge(channel_id: @channel.id)
    end

    def set_channel
      @channel = ChannelUser.find_by!(channel_id: params[:id], user_id: current_user.id).channel
    end
  end
end
