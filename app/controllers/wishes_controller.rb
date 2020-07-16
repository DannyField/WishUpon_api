class WishesController < ApplicationController

def index
    wishes = Wish.all
    render json: wishes
end

def show
    render json: @wish
end

def create
    Wish.create(wish_params)
    render json: "A new wish has been created", status: 200 
end

def update
    @wish.update(wish_params)
    render json: "The wish has been updated", status: 200
end

def destroy
    @wish.destroy
    render json: "The wish has been deleted", status: 200
end

private

def wish_params
    params.require(:wish).permit(:title, :description, :is_secret, :is_anonymous, :is_completed, :is_matched, :like, :expiry_time)
end
