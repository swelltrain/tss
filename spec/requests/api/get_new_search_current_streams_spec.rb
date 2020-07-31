# frozen_string_literal: true

RSpec.describe 'GET /api/search_current_streams/new', type: :request do
  subject { get '/api/search_current_streams/new', as: :json }

  it 'returns http status ok' do
    subject
    expect(response).to have_http_status(:ok)
  end

  it "renders search current streams form model " do
    subject
    expect(json_response).to eq({})
  end
end
