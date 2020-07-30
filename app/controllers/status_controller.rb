class StatusController < ApplicationController
  # Authicates the user before accessing the data
  before_action :authenticate_user

  # the index function will check whether a user is logged in
  def index
    render json: { message: 'logged in' }
  end

  def user
    render json: { user: current_user.email }
  end
end
