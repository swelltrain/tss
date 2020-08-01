# frozen_string_literal: true

class SearchCurrentStreams
  include ActiveModel::Model
  include ActiveModel::Serialization

  attr_accessor :streamer,
                :esrb_rating,
                :game_platform,
                :game_mode,
                :game_title,
                :game_viewership_min,
                :game_viewership_max,
                :genre,
                :theme

  # do we care to validate anything?  make sure there is at least one thing?
  # nah, i think just random if called with nothing?

  def attributes
    {
      'streamer' => nil,
      'esrb_rating' => nil,
      'game_platform' => nil,
      'game_mode' => nil,
      'game_title' => nil,
      'game_viewership_min' => nil,
      'game_viewership_max' => nil,
      'genre' => nil,
      'theme' => nil
    }
  end
end
