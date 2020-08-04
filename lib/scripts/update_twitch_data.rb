include ActionView::Helpers::DateHelper
STDOUT.sync = true

puts "Running Update Twitch Data Script *******************************"
retries = 3

begin
  Twitch::DataUpdater.new(retries).call
rescue => e
  puts "The Twitch::DataUpdater failed after #{retries} retries."
  puts e.message
  raise e
end
