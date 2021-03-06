# frozen_string_literal: true

module Api
  class ChannelsController < Api::BaseController
    def index
      channels = Channel.all
      if ActiveRecord::Type::Boolean.new.cast(params[:joined])
        channels = channels.joins(:channel_users).where('channel_users.user_id = ?', current_user.id).distinct
      end

      channels = channels.page(params[:page])

      render_success(
        resource: channels.as_json(only: %i[id name]),
        meta: { total_count: channels.total_count, total_pages: channels.total_pages },
        message: 'successful'
      )
    end
  end
end
