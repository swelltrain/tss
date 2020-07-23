class Platform < ApplicationRecord
  has_many :game_publishers, dependent: :destroy
  has_many :games, through: :game_publishers
end
