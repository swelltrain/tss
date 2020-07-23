class User < ApplicationRecord
  def streamer?
    twitch_streamer_login.present?
  end
end
