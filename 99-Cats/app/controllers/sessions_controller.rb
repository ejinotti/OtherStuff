class SessionsController < ApplicationController

  before_action :maybe_redirect_to_index, only: [:new]

  def new
    @user = User.new
    render :new
  end

  def create
    parms = session_params
    user_name, password = parms[:user_name], parms[:password]
    @user = User.find_by_credentials(user_name, password)

    if @user
      @user.reset_session_token!
      login!(@user)
      redirect_to cats_url
    else
      @user = User.new(user_name: user_name)
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  private

  def session_params
    params.require(:session).permit(:user_name, :password)
  end

  def maybe_redirect_to_index
    redirect_to cats_url if current_user
  end

end
