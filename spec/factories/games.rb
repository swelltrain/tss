# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    provider { 'whatever' }
    sequence :original_provider_id do |n|
      n
    end
    sequence :name do |n|
      "some name#{n}"
    end
  end
end
