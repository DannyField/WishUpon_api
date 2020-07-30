class CommentsController < ApplicationController
  # Authicates the user before accessing the data
  before_action :authenticate_user
  # Before edit/show or delete a wish find the wish using id from params
  before_action :find_comment, only: [:destroy]

  # sends the wishes to the front end. Contains all the wishes in the database
  def index
    @wish = Wish.find(params[:wish_id])
    comments = @wish.comments.all
    render json: comments.as_json(
      only: [:id, :content, :created_at],
      include: { user: { only: [:id, :first_name] } }
    )
  end

  # A wish can be created here with valid attributes. 
  # We create instances of comments, wish and current user
  # After the record is created and saved, render json with comment information
  # if comments is not saved, render json with a error message.
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

  # A wish to be destroyed. 
  def destroy
    @comment.destroy
    render json: {}, status: :no_content
  end

  private

  # Passing the contents of the wish, the wish_id, and the user 
  # assigned to the wish.
  def comment_params
    params.require(:comment).permit(:content, :wish_id, :user_id)
  end

  # Finds the comment associated with the wish
  def find_comment
    @comment = Comment.find(params[:id])
  end
end
