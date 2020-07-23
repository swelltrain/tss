class Theme < ApplicationRecord
  has_many :game_themes, dependent: :destroy
  has_many :games, through: :game_themes
end
