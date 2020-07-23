class Streamer < ApplicationRecord
  has_many :game_ratings, class_name: 'StreamerGameProfile', dependent: :nullify
  has_many :up_times, class_name: 'StreamerUpTime', dependent: :destroy
  has_one :current_stream, dependent: :destroy
  scope :likely_streaming_now, -> { joins(:current_stream).where(CurrentStream.arel_table[:updated_at].gt(15.minutes.ago)) }
  scope :with_current_game, -> (game_id) { likely_streaming_now.where(CurrentStream.arel_table[:game_id].eq(game_id)) }
  scope :with_viewership_between, -> (min, max) { where(arel_table[:view_count].between(min..max)) }

  def last_up_time
    up_times.last
  end

  def update_source_queried_at!(granularity = 15.minutes)
     self.update!(source_queried_at: Time.now.change(sec: 0) - granularity)
  end

  def profile_image_url(width, height)
    return '' if self[:profile_image_url].blank?
    self[:profile_image_url].gsub(/\{width\}/, width.to_s).gsub(/\{height\}/, height.to_s)
  end
end
