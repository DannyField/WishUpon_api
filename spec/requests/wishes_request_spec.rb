require 'rails_helper'

RSpec.describe "Wishes", type: :request do
  describe 'GET #index' do
    before(:example) do
      @first_wish = create(:wish)
      @last_wish = create(:wish)
      get '/wishes'
      @json_response = JSON.parse(response.body)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'JSON response contains the correct number of entries' do
      expect(@json_response['wishes'].count).to eq(2)
    end

    it 'JSON response body contains expected attributes' do
      expect(@json_response['wishes'][0]).to include({
        'id' => @first_wish.id,
        'title' => @first_wish.title,
        'description' => @first_wish.description,
      }) 
    end
  end

  describe 'POST #create' do
    context 'when the wish is valid' do
      before(:example) do
        @wish_params = attributes_for(:wish)
        post '/wishes', params: {wish: @wish_params }, headers: authenticated_header
      end

      it 'returns a http created status' do
        expect(response).to have_http_status(:created)
      end

      it 'saves the Wish to the database' do
        expect(Wish.last.title).to eq(@wish_params[:title])
      end
    end

    context 'when the wish is invalid' do
      before(:example) do
        @wish_params = attributes_for(:wish, :invalid)
        post '/wishes', params: { wish: @wish_params }, headers: authenticated_header
        @json_response = JSON.parse(response.body)
      end

      it 'returns status unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the correct number of errors' do
        expect(@json_response['errors'].count).to eq(2)
      end

      it 'errors contains the correct message' do
        expect(@json_response['errors'][0]).to eq("Title can't be blank")
      end
    end
  end

  describe "DELETE #destroy" do
    before(:example) do
      # Arrange
      @wish1 = create(:wish)
      @wish2 = create(:wish)
      # p Wish.all
      delete "/wishes/#{@wish1.id}"
    end

    it 'has a http no content response status' do
      expect(response).to have_http_status(:no_content)
    end

    it 'deletes the Wish from the database' do
      expect(Wish.count).to eq(1)
    end
  end

end
