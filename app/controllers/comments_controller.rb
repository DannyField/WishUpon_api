class CommentsController < ApplicationController
  before_action :authenticate_user
  before_action :find_comment, only: [:destroy]

  def index
    @wish = Wish.find(params[:wish_id])
    comments = @wish.comments.all
    render json: comments.as_json(
      only: [:id, :content, :created_at],
      include: { user: { only: [:id, :first_name] } }
    )
  end

  def create
    @wish = Wish.find(params[:wish_id])
    @comment = @wish.comments.new(comment_params)
    @comment.wish_id = @wish.id
    @comment.user = current_user
    if @comment.save
      render json: {}, status: :created
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
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
