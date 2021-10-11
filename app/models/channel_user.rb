# frozen_string_literal: true

class ChannelUser < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  validates :channel_id, uniqueness: { scope: :user_id }
end
