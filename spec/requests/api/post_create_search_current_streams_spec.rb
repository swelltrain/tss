# frozen_string_literal: true

RSpec.describe 'POST /api/search_current_streams', type: :request do
  subject { post '/api/search_current_streams' }

  it 'returns http status ok' do
    subject
    expect(response).to have_http_status(:ok)
  end

  let!(:curret_streams) { create_list(:current_stream, 2) }

  it "renders results as json" do
    subject
    expect(json_response.length).to eq(2)
  end
end
