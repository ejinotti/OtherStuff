class SessionsController < ApplicationController

  def new
    #@user = User.new
    render :new
  end

  def create
    #email = s_params[:email]
    @user = User.find_by_creds(params[:email], params[:password])

    if @user
      @user.reset_token!
      login_user(@user)
      redirect_to bands_url
    else
      # @user = User.new(email: email)
      flash.now[:notice] = "Invalid login creds!"
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  # private
  #
  # def s_params
  #   params.require(:user).permit(:email, :password)
  # end

end
