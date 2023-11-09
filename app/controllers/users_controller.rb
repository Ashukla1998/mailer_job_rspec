class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      SendWelcomeEmailJob.perform_later(@user)
      # redirect_to @user, notice: 'User was successfully created.'
      render json: {messages: "#{@user} is created sucessfully"},status: :ok
    else
      render json: {error: @user.errors.full_messages},status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name) 
  end
end
