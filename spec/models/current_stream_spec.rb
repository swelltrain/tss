require 'rails_helper'

describe CurrentStream, '#thumbnail_url', type: :model do
  context 'when thumbnail_url is present' do
    it 'should return string with sizes set' do
      cs = CurrentStream.new(thumbnail_url: "https://static-cdn.jtvnw.net/previews-ttv/live_user_destiny-{width}x{height}.jpg")
      expect(cs.thumbnail_url(5,7)).to eq("https://static-cdn.jtvnw.net/previews-ttv/live_user_destiny-5x7.jpg")
    end
  end

  context 'when thumbnail_url is blank' do
      it 'should return an empty string' do
      cs = CurrentStream.new
      expect(cs.thumbnail_url(2,2)).to eq('')
    end
  end
end
