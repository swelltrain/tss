class EsrbRating < ApplicationRecord
  has_many :games, dependent: :nullify
end
