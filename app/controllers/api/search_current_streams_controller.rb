# frozen_string_literal: true

module Api
  class SearchCurrentStreamsController < ApplicationController
    def new
      @search_current_streams = SearchCurrentStreams.new
      render json: @search_current_streams
    end

    def index
      options = {}
      results = CurrentStream.first(5)
      options[:meta] = { total: results.count }
      render json: CurrentStreamSerializer.new(results, options)
    end
  end
end
