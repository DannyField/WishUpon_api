require 'rails_helper'

RSpec.describe "Keywords", type: :request do
  describe 'GET #index' do
    before(:example) do
      @first_keyword = create(:keyword)
      @last_keyword = create(:keyword)
      get '/keywords', headers: authenticated_header
      @json_response = JSON.parse(response.body)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'JSON response contains the correct number of entries' do
      expect(@json_response['keywords'].count).to eq(2)
    end

    it 'JSON response body contains expected attributes' do
      expect(@json_response['keywords'][0]).to include({
        'id' => @first_keyword.id,
        'word' => @first_keyword.word,
      }) 
    end
  end
end
