# frozen_string_literal: true

FactoryBot.define do
  factory :channel do
    name { Faker::Name.name }
  end
end
