class CurrentStream < ApplicationRecord
  belongs_to :streamer
  belongs_to :game
  has_many :game_genres, through: :game
  has_many :genres, through: :game_genres
  has_many :game_themes, through: :game
  has_many :themes, through: :game_themes
  has_many :game_publishers, through: :game
  has_many :publishers, through: :game_publishers
  has_many :game_modes, through: :game
  has_many :modes, through: :game_modes
  has_many :game_platforms, through: :game
  has_many :platforms, through: :game_platforms

  scope :stale, -> (minutes=30) { where(arel_table[:updated_at].lt(minutes.minutes.ago)) }

  scope :viewers_between, -> (min: 0, max: 2147483647) { where(arel_table[:viewer_count].gteq(min)).where(arel_table[:viewer_count].lteq(max))}
  scope :with_sluggified_title, -> (slug) { joins(:game).where(Game.arel_table[:slug].matches("%#{slug}%")) }
  scope :with_streamer_name, -> (name) {  where(arel_table[:display_name].matches("#{name}%")) }
  scope :with_streamer_name_exactly, -> (name) { where(display_name: name) }
  scope :with_language, -> (language) { where(language: language) }
  scope :random, -> (n) { order("RANDOM()").limit(n) }

  def thumbnail_url(width, height)
    return '' if self[:thumbnail_url].blank?
    self[:thumbnail_url].gsub(/\{width\}/, width.to_s).gsub(/\{height\}/, height.to_s)
  end
end
