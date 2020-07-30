class HobbiesController < ApplicationController
  # Shows the hobbies stored in the database
  def index
    hobbies = Hobby.all
    render json: { hobbies: hobbies }
  end
end
