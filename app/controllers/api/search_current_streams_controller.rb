# frozen_string_literal: true

module Api
  class SearchCurrentStreamsController < ApplicationController
    def new
      @search_current_streams = SearchCurrentStreams.new
      render json: @search_current_streams
    end

    def index
      results = CurrentStream.first(5)
      render json: results
    end
  end
end
