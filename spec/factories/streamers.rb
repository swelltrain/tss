# frozen_string_literal: true

FactoryBot.define do
  factory :streamer do
    sequence :original_provider_id do |n|
      n
    end
    original_provider { "provider" }
    sequence :login do |n|
      "login_#{n}"
    end
    view_count { 12 }
  end
end
