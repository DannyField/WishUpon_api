class WishesController < ApplicationController
    before_action :authenticate_user
    before_action :find_wish, only: [:show, :update, :destroy]

    def index
        wishes = Wish.all
        render json: wishes.as_json(
      only: [:id, :title, :description, :created_at, :updated_at],
      include: { user: { only: [:id, :first_name] } }
    )
    end

    def show
        render json: @wish.as_json(
      only: [:id, :title, :description, :created_at, :updated_at],
      include: { user: { only: [:id, :first_name] } }
    )
    end

    def create
      wish = current_user.wishes.new(wish_params)
        if wish.save
            render json:{}, status: :created
        else
            render json: {errors: wish.errors.full_messages}, status: :unprocessable_entity 
        end
    end

    def update
        if @wish.update(wish_params)
            render json: {}, status: :no_content
        else 
            render json: {errors: @wish.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def destroy
        @wish = Wish.find(params[:id])
        @wish.destroy
        render json: {}, status: :no_content
    end

private

    def wish_params
        params.require(:wish).permit(:title, :description, :is_secret, :is_anonymous, :is_completed, :is_matched, :like, :expiry_time, :user_id)
    end

    def find_wish 
        @wish = Wish.find(params[:id])
    end


end