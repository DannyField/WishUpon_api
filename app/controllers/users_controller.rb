class UsersController < ApplicationController
    def create
        found = Country.find_by(name: country_params[:country])
        if !found
          found = Country.create(name: country_params[:country])
        end
        found.users.create(user_params)
        render json: "user created", status: 200
    end

    def show_user
      @user = current_user
      @hobbies = current_user.hobbies
      @country = current_user.country
      render json: {user: @user, hobbies: @hobbies, country: @country}
    end

    private

    # When creating a new user, it seems that country_id must be included
    def user_params
        params.require(:user).permit(:email, :password, :first_name,:last_name,:nickname,:age,:is_admin,:gender)
    end
    def country_params
      params.require(:user).permit(:country)
    end
end



        