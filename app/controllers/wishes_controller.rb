class WishesController < ApplicationController
  # Authenticate user before all actions
  # Before edit/show or delete a wish find the wish using id from params
  before_action :authenticate_user
  before_action :find_wish, only: [:show, :update, :destroy, :update_image, :update_likes]

  # the index function will only show wishes that are not secret wishes
  # (is_secret: false)
  def index
    wishes = Wish.all.with_attached_image.where(is_secret: false)
    render json: { wishes: generate_image_url(wishes) }
  end

  # the show function will show one wish based on id
  def show
    render json: { wishes: generate_image_url([@wish]) }
  end

  # show user wishes action will display only wishes that belong to current_user
  # also separate completed wishes and wishes that are not completed yet
  def show_user_wishes
    completed_wishes = current_user.wishes.with_attached_image.where(is_completed: true)
    not_completed_wishes = current_user.wishes.with_attached_image.where(is_completed: false)

    render json: { completed_wishes: generate_image_url(completed_wishes), not_completed_wishes: generate_image_url(not_completed_wishes) }
  end

  # This action can create a new wish record with valid attributes
  # After the record is created and saved, render json with wish information
  # if wish is not saved, render json with error message.
  def create
    wish = current_user.wishes.new(wish_params)
    if wish.save
      # for each of the keywords param, find the keyword in the keyword database,
      # if not found, create a new keyword and build a new relationship with the wish.
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

  # This action can update information with edited wish attributes
  def update
    # wish can be updated only when then wish belongs to current user
    if @wish.user_id == current_user.id

      if @wish.update(wish_params)
        if keywords_params[:keyword1]
          @wish.wish_keywords.delete_all
          [keywords_params[:keyword1], keywords_params[:keyword2], keywords_params[:keyword3]].each do |keyword|
            @wish.wish_keywords.create(keyword_id: find_create_keyword(keyword))
          end
        end
        render json: {}, status: :no_content
      else
        render json: { errors: @wish.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  # This action can update wish image
  def update_image
    # wish image can be updated only when then wish belongs to current user
    if @wish.user_id == current_user.id
      @wish.image.purge
      @wish.image.attach(wish_params[:image])
      render json: url_for(@wish.image)
    end
  end

  # All users can edit the like attribute of a wish
  def update_likes
    @wish.update(like_params)
  end

  # This action can destroy a wish record
  def destroy
    if @wish.user_id == current_user.id
      @wish = Wish.find(params[:id])
      @wish.destroy
      render json: {}, status: :no_content
    end
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

  # if wish has a image attached, generate a url for displaying image
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
