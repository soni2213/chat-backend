# frozen_string_literal: true

module Api
  class ChannelsController < Api::BaseController
    def index
      channels = Channel.all
      if ActiveRecord::Type::Boolean.new.cast(params[:joined])
        channels = channels.joins(:channel_users).where('channel_users.user_id = ?', current_user.id).distinct
      end
      render_success(
        resource: channels.page(params[:page]).as_json(only: %i[id name]),
        message: 'successful'
      )
    end
  end
end
