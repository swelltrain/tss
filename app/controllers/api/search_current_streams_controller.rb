# frozen_string_literal: true

module Api
  class SearchCurrentStreamsController < ApplicationController
    def new
      @search_current_streams = SearchCurrentStreams.new
      render json: @search_current_streams
    end
  end
end
