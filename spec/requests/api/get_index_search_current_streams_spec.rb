# frozen_string_literal: true

RSpec.describe 'GET /api/search_current_streams', type: :request do
  subject { get '/api/search_current_streams' }

  it 'returns http status ok' do
    subject
    expect(response).to have_http_status(:ok)
  end

  let!(:current_streams) { create_list(:current_stream, 2) }
  let(:first_stream) { current_streams.first }

  it "renders results as json" do
    subject
    response_data = json_response[:data]
    first_result = response_data.first
    expect(response_data.length).to eq(current_streams.length)
    expect(first_result[:attributes][:display_name]).to eq(first_stream.display_name)
    expect(first_result[:attributes][:language]).to eq(first_stream.language)
    expect(first_result[:attributes][:started_at]).to be_present
    expect(first_result[:attributes][:thumbnail_url]).to eq(first_stream.thumbnail_url)
    expect(first_result[:attributes][:title]).to eq(first_stream.title)
    expect(first_result[:attributes][:viewer_count]).to eq(first_stream.viewer_count)
    expect(first_result[:attributes][:channel]).to be_present
    expect(first_result[:attributes][:game_name]).to be_present
  end
end
