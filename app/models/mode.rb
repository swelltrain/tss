class Mode < ApplicationRecord
  has_many :game_modes, dependent: :destroy
  has_many :games, through: :game_modes
end
