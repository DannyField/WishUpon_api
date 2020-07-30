require 'rails_helper'

RSpec.describe "Hobbies", type: :request do
  describe 'GET #index' do
    before(:example) do
      @first_hobby = create(:hobby)
      @last_hobby = create(:hobby)
      get '/hobbies', headers: authenticated_header
      @json_response = JSON.parse(response.body)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'JSON response contains the correct number of entries' do
      expect(@json_response['hobbies'].count).to eq(2)
    end

    it 'JSON response body contains expected attributes' do
      expect(@json_response['hobbies'][0]).to include({
        'id' => @first_hobby.id,
        'name' => @first_hobby.name,
      }) 
    end
  end
end
