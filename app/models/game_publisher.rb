class GamePublisher < ApplicationRecord
  belongs_to :game
  belongs_to :publisher
end
