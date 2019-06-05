class UsersController < ApplicationController
  skip_before_action :authorize_request, only: [:index, :create]

  def index
    @users = User.all.paginate(page: params[:page], per_page: 20)
    json_response(@users)
  end

  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
