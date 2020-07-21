require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe 'GET #index' do
    before(:example) do
      @first_comment = create(:comment)
      @last_comment = create(:comment)
      get '/comments'
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
        'id' => @first_comment.id,
        'content' => @first_comment.title
      }) 
    end
  end

  describe 'POST #create' do
    context 'when the comment is valid' do
      before(:example) do
        @comment_params = attributes_for(:comment)
        post '/comments', params: {comment: @comment_params }, headers: authenticated_header
      end

      it 'returns a http created status' do
        expect(response).to have_http_status(:created)
      end

      it 'saves the Comment to the database' do
        expect(Comment.last.content).to eq(@comment_params[:content])
      end
    end

    context 'when the comment is invalid' do
      before(:example) do
        @comment_params = attributes_for(:comment, :invalid)
        post '/comments', params: { comment: @comment_params }, headers: authenticated_header
        @json_response = JSON.parse(response.body)
      end

      it 'returns status unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the correct number of errors' do
        expect(@json_response['errors'].count).to eq(2)
      end

      it 'errors contains the correct message' do
        expect(@json_response['errors'][0]).to eq("Content can't be blank")
      end
    end
  end

  describe "DELETE #destroy" do
    before(:example) do
      # Arrange
      @comment1 = create(:comment)
      @comment2 = create(:comment)
      # p Comment.all
      delete "/comments/#{@comment1.id}"
    end

    it 'has a http no content response status' do
      expect(response).to have_http_status(:no_content)
    end

    it 'deletes the Comment from the database' do
      expect(Comment.count).to eq(1)
    end
  end

  describe "PUT #update" do
    context 'when the params are valid' do

      before(:example) do
        # Arrange
        @comment1 = create(:comment)
        @updated_title = "Updated Comment"
        put "/comments/#{@comment1.id}", params: { comment: { title: @updated_title} }, headers: authenticated_header
        # p @comment1
      end

      it 'returns a http no content response status' do
        expect(response).to have_http_status(:no_content)
      end

      it 'update the comment attributes information in the database' do
        expect(Comment.find(@comment1.id).title).to eq("Updated Comment")
      end
    end

    context 'when the params are invalid' do
      before(:example) do
        @comment = create(:comment)
        put "/comments/#{@comment.id}", params: {comment:{content:nil}}, headers: authenticated_header
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