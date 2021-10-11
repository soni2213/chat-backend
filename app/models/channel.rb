# frozen_string_literal: true

class Channel < ApplicationRecord
  has_many :channel_users
  has_many :users, through: :channel_users

  has_many :chat_messages
end
