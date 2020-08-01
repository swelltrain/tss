# frozen_string_literal: true

FactoryBot.define do
  factory :current_stream do
    association :streamer
    association :game
    viewer_count { 1 }
    title { 'some_title' }
    language { 'EN' }
    sequence :streamers_original_provider_id do |n|
      n
    end

    sequence :display_name do |n|
      "display_name#{n}"
    end
  end
end
