# frozen_string_literal: true

FactoryBot.define do
  factory :chat_message do
    user
    channel
    text { Faker::Lorem.sentence }
  end
end
