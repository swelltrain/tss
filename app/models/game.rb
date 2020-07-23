class Game < ApplicationRecord
  has_many :channels
  has_many :streamer_ratings, class_name: 'StreamerGameProfile', dependent: :nullify
  has_many :streams, class_name: 'CurrentStream'
  has_many :game_genres, dependent: :destroy
  has_many :game_themes, dependent: :destroy
  has_many :game_publishers, dependent: :destroy
  has_many :game_modes, dependent: :destroy
  has_many :game_platforms, dependent: :destroy
  has_many :themes, through: :game_themes
  has_many :genres, through: :game_genres
  has_many :publishers, through: :game_publishers
  has_many :modes, through: :game_modes
  has_many :platforms, through: :game_platforms
  belongs_to :esrb_rating, optional: true
  scope :with_current_streams, -> { joins(:streams).where(CurrentStream.arel_table[:created_at].gt(15.minutes.ago)) }
  scope :with_igdb_source_id, -> { where(arel_table[:igdb_source_id].not_eq(nil)) }

  def self.sluggify(name)
    name.downcase
  end

  def name=(name)
    self[:name] = name
    self[:slug] = Game.sluggify(name)
  end
end
