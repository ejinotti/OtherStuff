class UsersController < ApplicationController

  before_action :maybe_redirect_to_index, only: [:new]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      redirect_to cats_url
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :user_name)
  end

  def maybe_redirect_to_index
    redirect_to cats_url if current_user
  end

end
