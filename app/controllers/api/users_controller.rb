class Api::UsersController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
        user = User.new(user_params)
        if user.save
            render json: {user: user}, status: :ok
        else
            render json: {errors: user.errors}, status: :unprocessable_entity
        end
    end

    def show
        user = User.find(params[:id])
        render json: {user: user}           
        # , status: :ok
    end

    private
    def user_params
        params.require(:user).permit(:name, :email, :password)
    end

end