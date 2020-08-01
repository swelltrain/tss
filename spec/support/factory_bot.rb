# frozen_string_literal: true

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  # this should not be necessary, but hhhmmmm?
  config.before(:suite) do
    FactoryBot.find_definitions
  end
end
