require 'rails_helper'

RSpec.describe "Wishes", type: :request do
  describe 'GET #index' do
    before(:example) do
      @first_wish = create(:wish)
      @last_wish = create(:wish)
      get '/wishes', headers: authenticated_header
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
      @user = user_with_wish
      @wish1 = @user.wishes.first
      delete "/wishes/#{@wish1.id}", headers: authenticate_user(@user)
    end

    it 'has a http no content response status' do
      expect(response).to have_http_status(:no_content)
    end

    it 'deletes the Wish from the database' do
      expect(Wish.count).to eq(0)
    end
  end

  describe "PUT #update" do
    context 'when the params are valid' do
      before(:example) do
        # Arrange
        @user = user_with_wish
        @wish1 = @user.wishes.first
        @updated_title = "Updated Wish"
        put "/wishes/#{@wish1.id}", params: { wish: { title: @updated_title} }, headers: authenticate_user(@user)
        # p @wish1
      end

      it 'returns a http no content response status' do
        expect(response).to have_http_status(:no_content)
      end

      it 'update the wish attributes information in the database' do
        expect(Wish.find(@wish1.id).title).to eq("Updated Wish")
      end
    end

    context 'when the params are invalid' do
      before(:example) do
        @user = user_with_wish
        @wish1 = @user.wishes.first
        put "/wishes/#{@wish1.id}", params: {wish:{title:nil}}, headers: authenticate_user(@user)
        # pp response
        @json_response = JSON.parse(response.body)
      end

      it 'returns a unprocessable entity response' do
        expect((response)).to have_http_status(:unprocessable_entity)
      end

      it 'has the correct number of errors' do
        expect(@json_response['errors'].count).to eq(2)
      end
    end
  end

end
