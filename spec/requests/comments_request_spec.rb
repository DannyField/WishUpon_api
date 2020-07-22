require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe 'GET #index' do
    before(:example) do
      @wish = wish_with_comments
      get "/wishes/#{@wish.id}/comments", headers: authenticated_header
      @json_response = JSON.parse(response.body)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'JSON response contains the correct number of entries' do
      expect(@json_response['comments'].count).to eq(2)
    end

    it 'JSON response body contains expected attributes' do
      expect(@json_response['comments'][0]).to include({
        'id' => @wish.comments.first.id,
        'content' => @wish.comments.first.content
      }) 
    end
  end

  describe 'POST #create' do
    context 'when the comment is valid' do
      before(:example) do
        @wish = wish_with_comments
        # p "attributes_for(:comment):#{attributes_for(:comment)}"
        @comment_params = attributes_for(:comment)
        post "/wishes/#{@wish.id}/comments", params: {comment: @comment_params }, headers: authenticated_header
      end

      it 'returns a http created status' do
        expect(response).to have_http_status(:created)
      end

      it 'saves the Comment to the database' do
        expect(Comment.last.content).to eq(@comment_params[:content])
      end
    end
  end

    context 'when the comment is invalid' do
      before(:example) do
        @wish = wish_with_comments
        @comment_params = attributes_for(:comment, :invalid)
        post "/wishes/#{@wish.id}/comments", params: { comment: @comment_params }, headers: authenticated_header
        @json_response = JSON.parse(response.body)
      end

      it 'returns status unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the correct number of errors' do
        expect(@json_response['errors'].count).to eq(2)
      end

      it 'errors contains the correct message' do
        p @json_response
        expect(@json_response['errors'][0]).to eq("Content can't be blank")
      end
    end

  describe "DELETE #destroy" do
    before(:example) do
      # Arrange
      @wish = wish_with_comments
      delete "/wishes/#{@wish.id}/comments/#{@wish.comments.first.id}", headers: authenticated_header
    end

    it 'has a http no content response status' do
      expect(response).to have_http_status(:no_content)
    end

    it 'deletes the Comment from the database' do
      expect(Comment.count).to eq(1)
    end
  end
end