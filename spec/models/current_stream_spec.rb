# frozen_string_literal: true

RSpec.describe CurrentStream, type: :model do
  describe 'factory' do
    it 'is valid' do
      expect(build(:current_stream)).to be_valid
    end
  end
  describe '#thumbnail_url' do
    context 'when thumbnail_url is present' do
      let(:current_stream) do
        build(
          :current_stream,
          thumbnail_url: "https://static-cdn.jtvnw.net/previews-ttv/live_user_destiny-{width}x{height}.jpg"
        )
      end
      it 'should return string with sizes set' do
        expect(current_stream.thumbnail_url(5,7)).to eq("https://static-cdn.jtvnw.net/previews-ttv/live_user_destiny-5x7.jpg")
      end
    end

    context 'when thumbnail_url is blank' do
      let(:current_stream) { build(:current_stream) }
      it 'should return an empty string' do
        expect(current_stream.thumbnail_url(2,2)).to eq('')
      end
    end
  end
end
