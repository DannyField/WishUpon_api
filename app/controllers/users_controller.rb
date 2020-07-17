class UsersController < ApplicationController
    def create 
        User.create(user_params)
        render json: "user created", status: 200
    end

    private

    # When creating a new user, it seems that country_id must be included otherwise the database will roll back
    def user_params
        params.require(:user).permit(:email, :password, :first_name,:last_name,:nickname,:age,:is_admin,:gender,:country_id)
    end
end



        