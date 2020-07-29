class HobbiesController < ApplicationController
  def index
    hobbies = Hobby.all
    render json: { hobbies: hobbies }
  end
end
