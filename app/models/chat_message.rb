class ChatMessage < ApplicationRecord
  PER_PAGE = 1
  belongs_to :channel
  belongs_to :user

  validate :channel_membership

  private

  def channel_membership
    return if ChannelUser.exists?(channel_id: channel_id, user_id: user_id)

    errors.add(:user_id, 'Must be a member to send message!')
  end
end
