require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'GET #show_user' do
    before(:example) do
      @user = create(:user)
      get '/users/current_user', headers: authenticate_user(@user)
      @json_response = JSON.parse(response.body)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'JSON response body contains expected attributes' do
      expect(@json_response['user']).to include({
        'id' => @user.id,
        'email' => @user.email,
        'first_name' => @user.first_name,
        'age'=> @user.age
      }) 
    end
  end
end
