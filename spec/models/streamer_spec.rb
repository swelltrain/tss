# frozen_string_literal: true

describe Streamer, type: :model do
  describe "factory" do
    it "should be valid" do
      expect(build(:streamer)).to be_valid
    end
  end
  
  describe '#update_source_queried_at!' do
    it 'should persist the source_queried_at to most recent 15 minutes' do
      travel_to Time.zone.local(2018, 1, 1, 10, 30, 30) do
        s = Streamer.create(original_provider_id: 1, original_provider: 'spec', login: 'spec', view_count: 0)
        s.update_source_queried_at!
        expect(Streamer.find(s.id).source_queried_at).to eq(Time.zone.local(2018, 1, 1, 10, 15, 0))
      end
    end
  end
end
