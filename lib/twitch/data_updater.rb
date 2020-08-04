module Twitch
  class DataUpdater
    def initialize(retries = 0)
      @retries = retries
      @retry_window = Time.now
    end

    def call
      begin
        @attempts ||= 0
        while true do
          start = Time.now

          Twitch::Downloaders::Streamers.new.call

          finish = Time.now

          sleep_seconds = (start + 15.minutes).to_i - finish.to_i

          if sleep_seconds > 0
            sleep(sleep_seconds)
          end
          reset_retries! if retries > 0
        end
      rescue => e
        # lets retry before we revoke the access token
        if (@attempts += 1) <= retries
          retry
        end

        Twitch::API.revoke_access_token
        raise e
      ensure
        Twitch::API.close_log_file
      end
    end

    private

    attr_accessor :retries

    def reset_retries!
      if (@retry_window + 12.hours) < Time.now
        @retry_window = Time.now
        @attempts = 0
      end
    end
  end
end
