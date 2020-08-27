# frozen_string_literal: true

RSpec.describe Api::CurrentStreamSerializer do
  subject { described_class.new(current_stream).serializable_hash }

  let(:current_stream) { create(:current_stream) }

  it "serializes" do
    results = subject[:data][:attributes]
    expect(results[:channel]).to eq(current_stream.streamer.login)
    expect(results[:game_name]).to eq(current_stream.game.name)
  end
end
