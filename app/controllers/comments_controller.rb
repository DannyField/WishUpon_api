class CommentsController < ApplicationController
    before_action :authenticate_user
    before_action :find_comment, only: [:destroy]

    def index
        comments = Comment.all
        render json: { comments: comments }
    end

    # def show
    #     render json: @comment
    # end

    def create
      comment = current_user.comments.new(comment_params)
        if comment.save
            render json:{}, status: :created
        else
            render json: {errors: comment.errors.full_messages}, status: :unprocessable_entity 
        end
    end

    def destroy
        @comment.destroy
        render json: {}, status: :no_content
    end

private

    def comment_params
        params.require(:comment).permit(:content, :wish_id, :user_id)
    end

    def find_comment
        @comment = Comment.find(params[:id])
    end
end
