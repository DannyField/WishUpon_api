class WishesController < ApplicationController
    before_action :find_wish, only: [:show, :update, :destroy]

    def index
        wishes = Wish.all
        render json: {wishes: wishes}
    end

    def show
        render json: @wish
    end

    def create
        wish = Wish.new(wish_params)
        puts wish.errors.full_mesages
        if wish.save
            render json: "A new wish has been created", status: :created
        else
            render json: {errors: wish.errors.full_mesages}, status: :unprocessable_entity 
    end

    def update
        @wish.update(wish_params)
        render json: "The wish has been updated", status: :unprocessable_entity
    end

    def destroy
        @wish = Wish.find(params[:id])
        @wish.destroy
        render json: {}, status: :no_content
    end

private

    def wish_params
        params.require(:wish).permit(:title, :description, :is_secret, :is_anonymous, :is_completed, :is_matched, :like, :expiry_time)
    end

    def find_wish 
        @wish = Wish.find(params[:id])
    end


end