# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :search_current_streams, only: %i[new create]
  end
end
