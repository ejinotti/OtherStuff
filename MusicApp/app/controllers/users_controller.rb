class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    @user.session_token = User.generate_token

    if @user.save
      login_user(@user)
      redirect_to bands_url
    else
      flash.now[:notice] = @user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
