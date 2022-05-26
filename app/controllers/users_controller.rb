class UsersController < ApplicationController
    before_action :authorize, only: [:show]
    def create 
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        user = User.find(session[:user_id])
        render json: user
    end

    private

    def authorize 
        return render json: {error: "Not Authorized"}, status: :unauthorized unless session.include? :user_id
    end

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end


# def create
#     user = User.find_by(username: params[:username])
#     if user&.authenticate(params[:password])
#         session[:user_id] = user.id
#         render json: user, status: :created
#     else
#         render json: {error: "you fucked up cuhhhz"}, status: :unauthorized
#     end

# end