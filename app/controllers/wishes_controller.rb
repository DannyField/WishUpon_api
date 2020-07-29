class WishesController < ApplicationController
  before_action :authenticate_user
  before_action :find_wish, only: [:show, :update, :destroy, :update_image, :update_likes]

  def index
    wishes = Wish.all.with_attached_image.where(is_secret: false)
    render json: { wishes: generate_image_url(wishes) }
  end

  def show
    render json: { wishes: generate_image_url([@wish]) }
  end

  def show_user_wishes
    completed_wishes = current_user.wishes.with_attached_image.where(is_completed: true)
    not_completed_wishes = current_user.wishes.with_attached_image.where(is_completed: false)

    render json: { completed_wishes: generate_image_url(completed_wishes), not_completed_wishes: generate_image_url(not_completed_wishes) }
  end

  def create
    wish = current_user.wishes.new(wish_params)
    if wish.save

      [keywords_params[:keyword1], keywords_params[:keyword2], keywords_params[:keyword3]].each do |keyword|
        wish.wish_keywords.create(keyword_id: find_create_keyword(keyword))
      end

      if wish_params[:image]
        render json: { wish: wish, image: url_for(wish.image) }, status: :created
      else
        render json: { wish: wish, image: '' }, status: :created
      end
    else
      render json: { errors: wish.errors.full_messages }, status: :unprocessable_entity
      end
  end

  def update
    if @wish.user_id == current_user.id

      if @wish.update(wish_params)
        @wish.wish_keywords.delete_all
        [keywords_params[:keyword1], keywords_params[:keyword2], keywords_params[:keyword3]].each do |keyword|
          @wish.wish_keywords.create(keyword_id: find_create_keyword(keyword))
        end
        render json: {}, status: :no_content
      else
        render json: { errors: @wish.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def update_image
    if @wish.user_id == current_user.id
      @wish.image.purge
      @wish.image.attach(wish_params[:image])
      render json: url_for(@wish.image)
    end
  end

  def update_likes
    @wish.update(like_params)
  end

  def destroy
    @wish = Wish.find(params[:id])
    @wish.destroy
    render json: {}, status: :no_content
  end

  private

  def wish_params
    params.require(:wish).permit(:title, :description, :is_secret, :is_anonymous, :is_completed, :is_matched, :like, :expiry_time, :user_id, :image)
  end

  def keywords_params
    params.require(:wish).permit(:keyword1, :keyword2, :keyword3)
  end

  def like_params
    params.require(:wish).permit(:like)
  end

  def find_wish
    @wish = Wish.find(params[:id])
  end

  def generate_image_url(wishes)
    wishes.map do |wish|
      if wish.image.attached?
        wish.attributes.merge(image: url_for(wish.image), user: wish.user.first_name, keywords: wish.keywords)
      else
        wish.attributes.merge(user: wish.user.first_name, keywords: wish.keywords)
      end
    end
  end

  def find_create_keyword(keyword)
    found = Keyword.find_by(word: keyword.downcase)
    if found
      return found.id
    else
      found = Keyword.create(word: keyword.downcase)
      return found.id
    end
  end
end
