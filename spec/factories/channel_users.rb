# frozen_string_literal: true

FactoryBot.define do
  factory :channel_user do
    user
    channel
  end
end
